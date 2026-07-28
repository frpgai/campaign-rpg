import json
import urllib.request
import re
import os
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

# URL base da API de Produção do D&D 5e SRD
API_BASE_URL = "https://www.dnd5eapi.co"

# Mapeamento de Tipagem de Equipamentos
EQUIPMENT_TYPE_MAP = {
    "Weapon": "weapon",
    "Armor": "armor",
    "Potion": "consumable",
    "Ring": "treasure",
    "Scroll": "consumable",
    "Staff": "weapon",
    "Wand": "tool",
    "Adventuring Gear": "tool",
    "Tools": "tool",
}

# Traduções das Perícias para PT-BR
SKILL_MAP = {
    "acrobatics": ("Acrobacia", "DEX"),
    "animal-handling": ("Adestrar Animais", "WIS"),
    "arcana": ("Arcanismo", "INT"),
    "athletics": ("Atletismo", "STR"),
    "deception": ("Enganação", "CHA"),
    "history": ("História", "INT"),
    "insight": ("Intuição", "WIS"),
    "intimidation": ("Intimidação", "CHA"),
    "investigation": ("Investigação", "INT"),
    "medicine": ("Medicina", "WIS"),
    "nature": ("Natureza", "INT"),
    "perception": ("Percepção", "WIS"),
    "performance": ("Atuação", "CHA"),
    "persuasion": ("Persuasão", "CHA"),
    "religion": ("Religião", "INT"),
    "sleight-of-hand": ("Prestidigitação", "DEX"),
    "stealth": ("Furtividade", "DEX"),
    "survival": ("Sobrevivência", "WIS"),
}

def to_snake_case(text):
    text = text.lower()
    text = re.sub(r'[^a-z0-9\s_]', '', text)
    text = re.sub(r'\s+', '_', text)
    return text

def parse_cost(cost_data):
    """Converte custos para Peças de Ouro (gp)"""
    if not cost_data:
        return 0.0
    quantity = cost_data.get("quantity", 0)
    unit = cost_data.get("unit", "gp").lower()
    if unit == "gp":
        return float(quantity)
    elif unit == "pp":
        return float(quantity) * 10.0
    elif unit == "ep":
        return float(quantity) * 0.5
    elif unit == "sp":
        return float(quantity) * 0.1
    elif unit == "cp":
        return float(quantity) * 0.01
    return float(quantity)

def fetch_json(url):
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response:
            return json.loads(response.read().decode('utf-8'))
    except Exception as e:
        return None

def fetch_detail(url):
    return fetch_json(url)

def generate_skills_sql(skills_list):
    sql_lines = [
        "-- Seed automática gerada para o catálogo de Perícias",
        "INSERT INTO skills (system_id, slug, name, description, key_attribute, enabled)",
        "SELECT s.id, t.slug, t.name, t.description, t.key_attribute, true",
        "FROM systems s",
        "CROSS JOIN (VALUES"
    ]
    value_rows = []
    for sk in skills_list:
        if not sk:
            continue
        slug = sk.get("index", "")
        # Traduz nome e busca atributo correspondente
        name, attr = SKILL_MAP.get(slug, (sk.get("name", ""), "STR"))
        
        desc = f"Perícia de {name} baseada em {attr}."
        if sk.get("desc"):
            desc_list = sk.get("desc")
            if isinstance(desc_list, list) and len(desc_list) > 0:
                desc = " ".join(desc_list).replace("'", "''")[:250]
                
        value_rows.append(f"  ('{slug}', '{name}', '{desc}', '{attr}')")
        
    sql_lines.append(",\n".join(value_rows))
    sql_lines.append(") AS t(slug, name, description, key_attribute)")
    sql_lines.append("WHERE s.slug = 'dnd_5e_srd_521'")
    sql_lines.append("ON CONFLICT (system_id, slug) DO UPDATE SET")
    sql_lines.append("  name = EXCLUDED.name, description = EXCLUDED.description,")
    sql_lines.append("  key_attribute = EXCLUDED.key_attribute, updated_at = now();")
    return "\n".join(sql_lines)

def generate_traits_sql(traits_list):
    sql_lines = [
        "-- Seed automática gerada para o catálogo unificado de Traços",
        "INSERT INTO traits (system_id, slug, name, description)",
        "SELECT s.id, t.slug, t.name, t.description",
        "FROM systems s",
        "CROSS JOIN (VALUES"
    ]
    value_rows = []
    # Adicionar também os traços manuais que normalizamos (para não perdê-los)
    manual_traits = {
        "versatility": ("Versatilidade", "Proficiência em 1 habilidade à escolha."),
        "determination": ("Determinação", "Recupera Inspiração Heroica a cada descanso longo."),
        "fast-learner": ("Aprendiz Rápido", "1 Façanha de Origem extra no nível 1."),
        "darkvision": ("Visão no Escuro", "Permite enxergar no escuro e na penumbra sem auxílio de luz artificial."),
        "keen-senses": ("Sentidos Aguçados", "Proficiência em Percepção."),
        "military-rank": ("Patente Militar", "Você possui uma patente militar antiga. Soldados comuns respeitam sua autoridade."),
        "contact": ("Contato de Confiança", "Você possui uma conexão com o submundo do crime para passar mensagens e obter boatos."),
        "shelter": ("Abrigo dos Fiéis", "Você e seus companheiros podem receber cura e hospitalidade gratuita em templos da sua fé.")
    }
    
    seen_slugs = set()
    for slug, (name, desc) in manual_traits.items():
        seen_slugs.add(slug)
        value_rows.append(f"  ('{slug}', '{name}', '{desc}')")
        
    for tr in traits_list:
        if not tr:
            continue
        slug = to_snake_case(tr.get("index", ""))
        
        # Ignorar se já incluído no mapeamento genérico ou manual
        if slug in seen_slugs or "darkvision" in slug or "keen_senses" in slug:
            continue
            
        seen_slugs.add(slug)
        name = tr.get("name", "").replace("'", "''")
        desc = "Traço de regra especial de D&D 5e."
        if tr.get("desc"):
            desc_list = tr.get("desc")
            if isinstance(desc_list, list) and len(desc_list) > 0:
                desc = " ".join(desc_list).replace("'", "''")[:250]
                
        value_rows.append(f"  ('{slug}', '{name}', '{desc}')")
        
    sql_lines.append(",\n".join(value_rows))
    sql_lines.append(") AS t(slug, name, description)")
    sql_lines.append("WHERE s.slug = 'dnd_5e_srd_521'")
    sql_lines.append("ON CONFLICT (system_id, slug) DO UPDATE SET")
    sql_lines.append("  name = EXCLUDED.name, description = EXCLUDED.description, updated_at = now();")
    return "\n".join(sql_lines)

def generate_equipment_sql(equipment_list):
    sql_lines = [
        "-- Seed automática gerada para o catálogo de itens",
        "INSERT INTO items (system_id, slug, name, description, type, weight_lb, value_gp, enabled)",
        "SELECT s.id, t.slug, t.name, t.description, t.type, t.weight_lb, t.value_gp, true",
        "FROM systems s",
        "CROSS JOIN (VALUES"
    ]
    value_rows = []
    for item in equipment_list:
        if not item:
            continue
        name = item.get("name", "Item Sem Nome").replace("'", "''")
        slug = to_snake_case(item.get("index", ""))
        eq_category = item.get("equipment_category", {}).get("name", "Adventuring Gear")
        item_type = EQUIPMENT_TYPE_MAP.get(eq_category, "tool")
        if "potion" in slug:
            item_type = "consumable"
        
        weight = float(item.get("weight", 0.0))
        value_gp = parse_cost(item.get("cost", {}))
        
        desc = f"Equipamento de aventura: {name}."
        if item.get("desc"):
            desc_list = item.get("desc")
            if isinstance(desc_list, list) and len(desc_list) > 0:
                desc = " ".join(desc_list).replace("'", "''")[:250]
        
        value_rows.append(f"  ('{slug}', '{name}', '{desc}', '{item_type}', {weight:.2f}, {value_gp:.2f})")
    
    sql_lines.append(",\n".join(value_rows))
    sql_lines.append(") AS t(slug, name, description, type, weight_lb, value_gp)")
    sql_lines.append("WHERE s.slug = 'dnd_5e_srd_521'")
    sql_lines.append("ON CONFLICT (system_id, slug) DO UPDATE SET")
    sql_lines.append("  name = EXCLUDED.name, description = EXCLUDED.description, type = EXCLUDED.type,")
    sql_lines.append("  weight_lb = EXCLUDED.weight_lb, value_gp = EXCLUDED.value_gp, updated_at = now();")
    return "\n".join(sql_lines)

def generate_monsters_sql(monsters_list):
    sql_lines = [
        "-- Seed automática gerada para o catálogo de criaturas",
        "INSERT INTO creatures (system_id, slug, name, description, type, challenge_rating, hit_points, armor_class, speed_json, stats, actions, enabled)",
        "SELECT s.id, t.slug, t.name, t.description, t.type, t.challenge_rating, t.hit_points, t.armor_class, t.speed_json::jsonb, t.stats::jsonb, t.actions::jsonb, true",
        "FROM systems s",
        "CROSS JOIN (VALUES"
    ]
    value_rows = []
    for monster in monsters_list:
        if not monster:
            continue
        name = monster.get("name", "Criatura Sem Nome").replace("'", "''")
        slug = to_snake_case(monster.get("index", ""))
        m_type = monster.get("type", "monstrosity").lower().replace("'", "''")
        cr = float(monster.get("challenge_rating", 0.0))
        hp = int(monster.get("hit_points", 10))
        
        ac_list = monster.get("armor_class", [])
        ac = ac_list[0].get("value", 10) if isinstance(ac_list, list) and len(ac_list) > 0 else 10
            
        stats = {
            "strength": monster.get("strength", 10),
            "dexterity": monster.get("dexterity", 10),
            "constitution": monster.get("constitution", 10),
            "intelligence": monster.get("intelligence", 10),
            "wisdom": monster.get("wisdom", 10),
            "charisma": monster.get("charisma", 10)
        }
        stats_json = json.dumps(stats).replace("'", "''")
        speed_json = json.dumps(monster.get("speed", {"walk": "30 ft"})).replace("'", "''")
        
        actions = monster.get("actions", [])
        actions_min = [{"name": act.get("name", ""), "desc": act.get("desc", "")} for act in actions]
        actions_json = json.dumps(actions_min).replace("'", "''")
        
        desc = f"Criatura do tipo {m_type}. Nível de desafio {cr}."
        value_rows.append(f"  ('{slug}', '{name}', '{desc}', '{m_type}', {cr:.2f}, {hp}, {ac}, '{speed_json}', '{stats_json}', '{actions_json}')")
        
    sql_lines.append(",\n".join(value_rows))
    sql_lines.append(") AS t(slug, name, description, type, challenge_rating, hit_points, armor_class, speed_json, stats, actions)")
    sql_lines.append("WHERE s.slug = 'dnd_5e_srd_521'")
    sql_lines.append("ON CONFLICT (system_id, slug) DO UPDATE SET")
    sql_lines.append("  name = EXCLUDED.name, description = EXCLUDED.description, type = EXCLUDED.type, challenge_rating = EXCLUDED.challenge_rating,")
    sql_lines.append("  hit_points = EXCLUDED.hit_points, armor_class = EXCLUDED.armor_class, speed_json = EXCLUDED.speed_json,")
    sql_lines.append("  stats = EXCLUDED.stats, actions = EXCLUDED.actions, updated_at = now();")
    return "\n".join(sql_lines)

def generate_ancestries_sql(races_list):
    sql_lines = [
        "-- Seed automática gerada para as Ancestralidades",
        "INSERT INTO ancestries (system_id, slug, name, description, icon, speed, hp_bonus_per_level, enabled)",
        "SELECT s.id, t.slug, t.name, t.description, t.icon, t.speed, t.hp_bonus_per_level, true",
        "FROM systems s",
        "CROSS JOIN (VALUES"
    ]
    value_rows = []
    relations_rows = []
    
    race_names = {"human": "Humano", "elf": "Elfo", "dwarf": "Anão", "halfling": "Halfling", "dragonborn": "Draconato", "gnome": "Gnomo", "half-elf": "Meio-Elfo", "half-orc": "Meio-Orc", "tiefling": "Tiferino"}
    race_icons = {"human": "user", "elf": "sparkles", "dwarf": "shield", "orc": "sword", "halfling": "feather", "dragonborn": "flame", "gnome": "compass", "half-elf": "award", "half-orc": "zap", "tiefling": "skull"}
    
    for race in races_list:
        if not race:
            continue
        slug = to_snake_case(race.get("index", ""))
        name = race_names.get(slug, race.get("name", "")).replace("'", "''")
        icon = race_icons.get(slug, "user")
        speed = int(race.get("speed", 30))
        hp_bonus = 1 if slug == "dwarf" else 0
        desc = f"Origem biológica e cultural: {name}."
        value_rows.append(f"  ('{slug}', '{name}', '{desc}', '{icon}', {speed}, {hp_bonus})")
        
        traits = race.get("traits", [])
        for tr in traits:
            tr_slug = to_snake_case(tr.get("index", ""))
            if "darkvision" in tr_slug:
                tr_slug = "darkvision"
            elif "keen_senses" in tr_slug:
                tr_slug = "keen-senses"
            relations_rows.append(f"  ('{slug}', '{tr_slug}')")

    sql_lines.append(",\n".join(value_rows))
    sql_lines.append(") AS t(slug, name, description, icon, speed, hp_bonus_per_level)")
    sql_lines.append("WHERE s.slug = 'dnd_5e_srd_521'")
    sql_lines.append("ON CONFLICT (system_id, slug) DO UPDATE SET")
    sql_lines.append("  name = EXCLUDED.name, description = EXCLUDED.description, icon = EXCLUDED.icon, speed = EXCLUDED.speed,")
    sql_lines.append("  hp_bonus_per_level = EXCLUDED.hp_bonus_per_level, updated_at = now();\n")
    
    sql_lines.append("INSERT INTO ancestry_traits (ancestry_id, trait_id, description_override)")
    sql_lines.append("SELECT a.id, tr.id, NULL")
    sql_lines.append("FROM ancestries a")
    sql_lines.append("JOIN systems s ON a.system_id = s.id")
    sql_lines.append("CROSS JOIN traits tr")
    sql_lines.append("CROSS JOIN (VALUES")
    sql_lines.append(",\n".join(relations_rows))
    sql_lines.append(") AS t(ancestry_slug, trait_slug)")
    sql_lines.append("WHERE s.slug = 'dnd_5e_srd_521' AND a.slug = t.ancestry_slug AND tr.slug = t.trait_slug AND tr.system_id = s.id")
    sql_lines.append("ON CONFLICT (ancestry_id, trait_id) DO NOTHING;")
    return "\n".join(sql_lines)

def generate_backgrounds_sql(bg_list):
    sql_lines = [
        "-- Seed automática gerada para os Antecedentes",
        "INSERT INTO backgrounds (system_id, slug, name, description, icon, eligible_attributes, enabled)",
        "SELECT s.id, t.slug, t.name, t.description, t.icon, t.eligible_attributes, true",
        "FROM systems s",
        "CROSS JOIN (VALUES"
    ]
    value_rows = []
    bg_icons = {"soldier": "crosshair", "sage": "book-open", "criminal": "fingerprint", "acolyte": "heart"}
    for bg in bg_list:
        if not bg:
            continue
        slug = to_snake_case(bg.get("index", ""))
        name = bg.get("name", "").replace("'", "''")
        desc = f"Antecedente de origem: {name}."
        icon = bg_icons.get(slug, "award")
        
        attrs = "ARRAY['STR', 'DEX', 'CON']::TEXT[]"
        if slug == "sage":
            attrs = "ARRAY['CON', 'INT', 'WIS']::TEXT[]"
        elif slug == "acolyte":
            attrs = "ARRAY['INT', 'WIS', 'CHA']::TEXT[]"
        elif slug == "criminal":
            attrs = "ARRAY['DEX', 'CON', 'INT']::TEXT[]"
            
        value_rows.append(f"  ('{slug}', '{name}', '{desc}', '{icon}', {attrs})")
        
    sql_lines.append(",\n".join(value_rows))
    sql_lines.append(") AS t(slug, name, description, icon, eligible_attributes)")
    sql_lines.append("WHERE s.slug = 'dnd_5e_srd_521'")
    sql_lines.append("ON CONFLICT (system_id, slug) DO UPDATE SET")
    sql_lines.append("  name = EXCLUDED.name, description = EXCLUDED.description, icon = EXCLUDED.icon,")
    sql_lines.append("  eligible_attributes = EXCLUDED.eligible_attributes, updated_at = now();")
    return "\n".join(sql_lines)

def generate_vocations_sql(classes_list):
    sql_lines = [
        "-- Seed automática gerada para as Vocações (Classes)",
        "INSERT INTO vocations (system_id, slug, name, description, key_attribute, hit_die, is_spellcaster, spell_slots_by_level, enabled)",
        "SELECT s.id, t.slug, t.name, t.description, t.key_attribute, t.hit_die, t.is_spellcaster, t.spell_slots_by_level, true",
        "FROM systems s",
        "CROSS JOIN (VALUES"
    ]
    value_rows = []
    class_names = {"fighter": "Guerreiro", "wizard": "Mago", "rogue": "Ladino", "paladin": "Paladino", "barbarian": "Bárbaro", "bard": "Bardo", "cleric": "Clérigo", "druid": "Druida", "monk": "Monge", "ranger": "Patrulheiro", "sorcerer": "Feiticeiro", "warlock": "Bruxo"}
    key_attrs = {"fighter": "STR", "wizard": "INT", "rogue": "DEX", "paladin": "CHA", "barbarian": "STR", "bard": "CHA", "cleric": "WIS", "druid": "WIS", "monk": "DEX", "ranger": "DEX", "sorcerer": "CHA", "warlock": "CHA"}
    
    for cls in classes_list:
        if not cls:
            continue
        slug = to_snake_case(cls.get("index", ""))
        name = class_names.get(slug, cls.get("name", "")).replace("'", "''")
        hit_die = int(cls.get("hit_die", 8))
        key_attr = key_attrs.get(slug, "STR")
        
        is_spellcaster = "spellcasting" in cls and cls["spellcasting"] is not None
        slots = '{"1": 2}' if is_spellcaster else '{}'
        desc = f"Vocação e treinamento de combate/misticismo: {name}."
        value_rows.append(f"  ('{slug}', '{name}', '{desc}', '{key_attr}', {hit_die}, {str(is_spellcaster).lower()}, '{slots}'::jsonb)")
        
    sql_lines.append(",\n".join(value_rows))
    sql_lines.append(") AS t(slug, name, description, key_attribute, hit_die, is_spellcaster, spell_slots_by_level)")
    sql_lines.append("WHERE s.slug = 'dnd_5e_srd_521'")
    sql_lines.append("ON CONFLICT (system_id, slug) DO UPDATE SET")
    sql_lines.append("  name = EXCLUDED.name, description = EXCLUDED.description, key_attribute = EXCLUDED.key_attribute,")
    sql_lines.append("  hit_die = EXCLUDED.hit_die, is_spellcaster = EXCLUDED.is_spellcaster,")
    sql_lines.append("  spell_slots_by_level = EXCLUDED.spell_slots_by_level, updated_at = now();")
    return "\n".join(sql_lines)

def process_parallel(items_info, category_name):
    results = []
    total = len(items_info)
    print(f"Baixando detalhes de {total} itens de '{category_name}' usando concorrência (ThreadPool)...")
    
    with ThreadPoolExecutor(max_workers=25) as executor:
        futures = {executor.submit(fetch_detail, f"{API_BASE_URL}{item['url']}"): item for item in items_info}
        
        count = 0
        for future in as_completed(futures):
            res = future.result()
            if res:
                results.append(res)
            count += 1
            if count % 50 == 0 or count == total:
                print(f"Progresso '{category_name}': {count}/{total} baixados...")
                
    return results

def main():
    start_time = time.time()
    print("=== D&D 5e Online REST API -> SQL Extração Completa ===")
    os.makedirs("output", exist_ok=True)
    
    # 1. Processar Perícias (Skills)
    skills_index = fetch_json(f"{API_BASE_URL}/api/2014/skills")
    if skills_index and "results" in skills_index:
        skills_details = process_parallel(skills_index["results"], "Perícias")
        with open("output/seed_pericias.sql", "w", encoding="utf-8") as f:
            f.write(generate_skills_sql(skills_details))
        print("Salvo: output/seed_pericias.sql")
        
    # 2. Processar Traços (Traits)
    traits_index = fetch_json(f"{API_BASE_URL}/api/2014/traits")
    if traits_index and "results" in traits_index:
        # Traços no D&D são muitos (~70), baixar em paralelo
        traits_details = process_parallel(traits_index["results"], "Traços")
        with open("output/seed_tracos.sql", "w", encoding="utf-8") as f:
            f.write(generate_traits_sql(traits_details))
        print("Salvo: output/seed_tracos.sql")
        
    # 3. Processar Equipamentos
    eq_index = fetch_json(f"{API_BASE_URL}/api/2014/equipment")
    if eq_index and "results" in eq_index:
        eq_details = process_parallel(eq_index["results"], "Equipamentos")
        with open("output/seed_itens.sql", "w", encoding="utf-8") as f:
            f.write(generate_equipment_sql(eq_details))
        print("Salvo: output/seed_itens.sql")
        
    # 4. Processar Criaturas (Monstros)
    monsters_index = fetch_json(f"{API_BASE_URL}/api/2014/monsters")
    if monsters_index and "results" in monsters_index:
        monster_details = process_parallel(monsters_index["results"], "Monstros")
        with open("output/seed_criaturas.sql", "w", encoding="utf-8") as f:
            f.write(generate_monsters_sql(monster_details))
        print("Salvo: output/seed_criaturas.sql")
        
    # 5. Processar Ancestralidades (Races)
    races_index = fetch_json(f"{API_BASE_URL}/api/2014/races")
    if races_index and "results" in races_index:
        races_details = process_parallel(races_index["results"], "Ancestralidades")
        with open("output/seed_ancestralidades.sql", "w", encoding="utf-8") as f:
            f.write(generate_ancestries_sql(races_details))
        print("Salvo: output/seed_ancestralidades.sql")
        
    # 6. Processar Antecedentes (Backgrounds)
    bg_index = fetch_json(f"{API_BASE_URL}/api/2014/backgrounds")
    if bg_index and "results" in bg_index:
        bg_details = process_parallel(bg_index["results"], "Antecedentes")
        with open("output/seed_antecedentes.sql", "w", encoding="utf-8") as f:
            f.write(generate_backgrounds_sql(bg_details))
        print("Salvo: output/seed_antecedentes.sql")
        
    # 7. Processar Vocações (Classes)
    classes_index = fetch_json(f"{API_BASE_URL}/api/2014/classes")
    if classes_index and "results" in classes_index:
        classes_details = process_parallel(classes_index["results"], "Vocações")
        with open("output/seed_vocacoes.sql", "w", encoding="utf-8") as f:
            f.write(generate_vocations_sql(classes_details))
        print("Salvo: output/seed_vocacoes.sql")
        
    duration = time.time() - start_time
    print(f"\nExtração total concluída com sucesso em {duration:.1f} segundos!")

if __name__ == "__main__":
    main()
