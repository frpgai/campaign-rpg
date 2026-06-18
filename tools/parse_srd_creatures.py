#!/usr/bin/env python3
"""
Parse SRD 5.2.1 creature stat blocks from srd521.txt and generate
a PostgreSQL seed SQL file for the creatures table.

Usage:
    python parse_srd_creatures.py [--srd PATH] [--out PATH] [--debug]

Output: creatures_seed.sql  (INSERT statements, ON CONFLICT DO UPDATE)
"""

import re
import sys
import json
import argparse
from pathlib import Path
from dataclasses import dataclass, field
from typing import Optional


# ---------------------------------------------------------------------------
# Data model
# ---------------------------------------------------------------------------

@dataclass
class Creature:
    name: str
    slug: str
    size: str
    creature_type: str
    alignment: str
    armor_class: int
    hit_points: int
    hit_dice: str
    speed: dict
    str_: int
    dex: int
    con: int
    int_: int
    wis: int
    cha: int
    saving_throws: dict           # only abilities with proficiency: {"wis": bonus}
    skills: dict                  # handled separately (creature_skills table)
    damage_vulnerabilities: list
    damage_resistances: list
    damage_immunities: list
    condition_immunities: list
    senses: dict
    languages: Optional[str]
    challenge_rating: str
    xp: int
    proficiency_bonus: int
    traits: list                  # [{name, description}]
    actions: list                 # [{name, description}]
    bonus_actions: list
    reactions: list
    legendary_actions: list


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

CR_TO_XP = {
    "0": 10, "1/8": 25, "1/4": 50, "1/2": 100,
    "1": 200, "2": 450, "3": 700, "4": 1100, "5": 1800,
    "6": 2300, "7": 2900, "8": 3900, "9": 5000, "10": 5900,
    "11": 7200, "12": 8400, "13": 10000, "14": 11500, "15": 13000,
    "16": 15000, "17": 18000, "18": 20000, "19": 22000, "20": 25000,
    "21": 33000, "22": 41000, "23": 50000, "24": 62000,
    "30": 155000,
}

SIZE_MAP = {
    "tiny": "Tiny", "small": "Small", "medium": "Medium",
    "large": "Large", "huge": "Huge", "gargantuan": "Gargantuan",
}

ABILITY_NAMES = ["str", "dex", "con", "int", "wis", "cha"]

DAMAGE_TYPES = {
    "acid", "bludgeoning", "cold", "fire", "force", "lightning",
    "necrotic", "piercing", "poison", "psychic", "radiant", "slashing",
    "thunder",
    # nonmagical qualifiers kept as-is
    "nonmagical bludgeoning", "nonmagical piercing", "nonmagical slashing",
    "nonmagical bludgeoning, piercing, and slashing",
    "bludgeoning, piercing, and slashing from nonmagical attacks",
}

CONDITION_TYPES = {
    "blinded", "charmed", "deafened", "exhaustion", "frightened",
    "grappled", "incapacitated", "invisible", "paralyzed", "petrified",
    "poisoned", "prone", "restrained", "stunned", "unconscious",
}


def slugify(name: str) -> str:
    s = name.lower().strip()
    s = re.sub(r"[^a-z0-9]+", "-", s)
    s = s.strip("-")
    return s


def parse_int_safe(s: str) -> int:
    s = s.strip().replace(",", "").replace("+", "")
    try:
        return int(s)
    except ValueError:
        return 0


def parse_cr(cr_str: str) -> tuple[str, int]:
    """Returns (cr_string, xp). cr_str like '1/4 (XP 50; PB +2)'"""
    m = re.match(r"([\d/]+)\s*\(XP\s*([\d,]+)", cr_str)
    if m:
        cr = m.group(1)
        xp = int(m.group(2).replace(",", ""))
        return cr, xp
    # fallback
    m2 = re.match(r"([\d/]+)", cr_str)
    if m2:
        cr = m2.group(1)
        return cr, CR_TO_XP.get(cr, 0)
    return "0", 0


def parse_speed(speed_str: str) -> dict:
    """'30 ft., Fly 60 ft., Swim 30 ft.' → {"walk":30,"fly":60,"swim":30}"""
    speed = {}
    # normalize unicode minus
    s = speed_str.replace("−", "-").lower()
    parts = re.split(r",\s*", s)
    for part in parts:
        part = part.strip()
        m = re.match(r"(?:(fly|swim|climb|burrow|hover)\s+)?(\d+)\s*ft", part)
        if m:
            mode = m.group(1) or "walk"
            val = int(m.group(2))
            speed[mode] = val
        elif "hover" in part:
            speed["hover"] = True
    return speed


def parse_senses(senses_str: str) -> dict:
    """'Darkvision 60 ft.; Passive Perception 9' → {"darkvision":60,"passive_perception":9}"""
    senses = {}
    s = senses_str
    for m in re.finditer(r"(darkvision|blindsight|truesight|tremorsense)\s+(\d+)\s*ft", s, re.I):
        senses[m.group(1).lower()] = int(m.group(2))
    m = re.search(r"passive perception\s+(\d+)", s, re.I)
    if m:
        senses["passive_perception"] = int(m.group(1))
    return senses


def parse_damage_list(raw: str) -> list:
    """
    'Bludgeoning, Piercing, and Slashing from Nonmagical Attacks; Fire'
    → ['bludgeoning, piercing, and slashing from nonmagical attacks', 'fire']
    Handles semicolon-separated groups.
    """
    result = []
    groups = re.split(r";", raw)
    for g in groups:
        g = g.strip().rstrip(".").lower()
        if g:
            result.append(g)
    return result


def parse_condition_list(raw: str) -> list:
    result = []
    for part in re.split(r"[;,]", raw):
        p = part.strip().lower()
        if p:
            result.append(p)
    return result


def parse_skills(raw: str) -> dict:
    """'Stealth +6, Perception +3' → {"stealth": 6, "perception": 3}"""
    skills = {}
    for m in re.finditer(r"([A-Za-z ]+?)\s*\+(\d+)", raw):
        skill = m.group(1).strip().lower().replace(" ", "_")
        # normalize multi-word skills
        skill = {
            "animal_handling": "animal_handling",
            "sleight_of_hand": "sleight_of_hand",
        }.get(skill, skill)
        skills[skill] = int(m.group(2))
    return skills


def sql_escape(s: str) -> str:
    return s.replace("'", "''")


def sql_str(s: Optional[str]) -> str:
    if s is None:
        return "NULL"
    return f"'{sql_escape(s)}'"


def sql_jsonb(d: dict) -> str:
    if not d:
        return "'{}'::JSONB"
    return f"'{json.dumps(d, ensure_ascii=False)}'::JSONB"


def sql_array(lst: list) -> str:
    if not lst:
        return "ARRAY[]::TEXT[]"
    escaped = [f"'{sql_escape(x)}'" for x in lst]
    return f"ARRAY[{', '.join(escaped)}]"


def sql_jsonb_actions(lst: list) -> str:
    if not lst:
        return "'[]'::JSONB"
    return f"'{json.dumps(lst, ensure_ascii=False)}'::JSONB"


# ---------------------------------------------------------------------------
# Stat block parser
# ---------------------------------------------------------------------------

def find_stat_block_ranges(lines: list[str]) -> list[tuple[int, int]]:
    """
    A stat block starts with a creature name line followed immediately by
    a size+type+alignment line, then AC/HP/Speed.
    Returns list of (start_line, end_line) ranges (0-indexed).
    """
    SIZE_PATTERN = re.compile(
        r"^(Tiny|Small|Medium|Large|Huge|Gargantuan)\s+\w",
        re.IGNORECASE
    )
    AC_PATTERN = re.compile(r"^AC\s+\d+")

    ranges = []
    i = 0
    while i < len(lines) - 4:
        line = lines[i].strip()
        # Candidate: non-empty line that looks like a name (title case, no numbers at start)
        if (line and
                not line.startswith("System Reference") and
                not re.match(r"^\d", line) and
                not re.match(r"^(Actions|Bonus Actions|Reactions|Traits|Legendary)", line) and
                not re.match(r"^(AC|HP|Speed|CR|MOD|Str|Int|Skills|Senses|Immunities|Vulnerabilities|Resistances|Saving|Languages|Initiative|Gear)", line, re.I)):
            # Check next non-empty line for size+type
            j = i + 1
            while j < len(lines) and not lines[j].strip():
                j += 1
            if j < len(lines) and SIZE_PATTERN.match(lines[j].strip()):
                # Check for AC within next 15 lines
                k = j + 1
                found_ac = False
                while k < min(j + 20, len(lines)):
                    if AC_PATTERN.match(lines[k].strip()):
                        found_ac = True
                        break
                    k += 1
                if found_ac:
                    ranges.append((i, None))  # end TBD
        i += 1

    # Fill end ranges
    result = []
    for idx, (start, _) in enumerate(ranges):
        end = ranges[idx + 1][0] if idx + 1 < len(ranges) else len(lines)
        result.append((start, end))
    return result


def parse_ability_line(block_lines: list[str]) -> tuple[dict, dict]:
    """
    Find the MOD SAVE table and extract ability scores + saving throw proficiencies.
    Returns (abilities: {str,dex,...: int}, saving_throws: {ability: bonus})
    """
    abilities = {a: 10 for a in ABILITY_NAMES}
    saving_throws = {}

    # Find "MOD SAVE" marker lines
    mod_indices = [i for i, l in enumerate(block_lines) if "MOD SAVE" in l]
    if len(mod_indices) < 2:
        return abilities, saving_throws

    # The ability data sits between first and second MOD SAVE markers
    start = mod_indices[0] + 1
    end = mod_indices[1]
    ability_text = " ".join(block_lines[start:end])
    # normalize unicode minus sign
    ability_text = ability_text.replace("−", "-").replace("−", "-")

    # Pattern: AbilityName score mod save  (repeated 6 times, possibly across lines)
    pattern = re.compile(
        r"(Str|Dex|Con|Int|WIS|WiS|Wis|CHA|Cha|cha)\s+(\d+)\s+([+-]\d+)\s+([+-]\d+)",
        re.IGNORECASE
    )
    found = pattern.findall(ability_text)
    if len(found) < 6:
        # Try wider search
        wider = " ".join(block_lines[max(0, mod_indices[0]-2):min(len(block_lines), mod_indices[-1]+5)])
        wider = wider.replace("−", "-").replace("−", "-")
        found = pattern.findall(wider)

    ability_order = ["str", "dex", "con", "int", "wis", "cha"]
    for i, (name, score, mod, save) in enumerate(found[:6]):
        ab = ability_order[i]
        abilities[ab] = int(score)
        score_mod = (int(score) - 10) // 2
        save_val = int(save)
        if save_val != score_mod:
            saving_throws[ab] = save_val

    return abilities, saving_throws


def parse_section(block_lines: list[str], header: str) -> list[dict]:
    """Extract named entries under a section header (Actions, Traits, etc.)"""
    entries = []
    in_section = False
    current_name = None
    current_desc = []

    section_headers = {"Actions", "Bonus Actions", "Reactions", "Traits",
                       "Legendary Actions", "Lair Actions", "Regional Effects"}

    # Markers that signal we've left the stat block into adjacent column text
    ESCAPE_PATTERNS = re.compile(
        r"^(Level \d|Casting Time:|Range:|Components:|Duration:|Using a Higher|"
        r"Cantrip|System Reference Document)",
        re.I
    )

    for line in block_lines:
        stripped = line.strip()
        if stripped == header:
            in_section = True
            continue
        if in_section and stripped in section_headers and stripped != header:
            in_section = False
        if not in_section:
            continue
        # Stop if we've drifted into spell descriptions
        if ESCAPE_PATTERNS.match(stripped):
            in_section = False
            continue

        # Check if line starts a new entry: "EntryName. Description"
        m = re.match(r"^([A-Z][^.]{1,60})\.\s+(.+)", stripped)
        if m and not stripped.startswith("Melee") and not stripped.startswith("Ranged"):
            if current_name:
                desc = " ".join(current_desc).strip()[:500]  # cap at 500 chars
                entries.append({"name": current_name, "description": desc})
            current_name = m.group(1).strip()
            current_desc = [m.group(2).strip()]
        elif current_name and stripped:
            # Stop accumulating if we've hit too much text (column bleed)
            current_text_len = sum(len(d) for d in current_desc)
            if current_text_len < 500:
                current_desc.append(stripped)

    if current_name:
        desc = " ".join(current_desc).strip()[:500]
        entries.append({"name": current_name, "description": desc})

    return entries


def parse_block(lines: list[str], start: int, end: int, debug: bool = False) -> Optional[Creature]:
    block = lines[start:end]
    block_stripped = [l.strip() for l in block]

    # Name: first non-empty line
    name = ""
    name_idx = 0
    for i, l in enumerate(block_stripped):
        if l and not l.startswith("System Reference"):
            name = l
            name_idx = i
            break
    if not name:
        return None

    # Type line: size type, alignment
    type_line = ""
    for l in block_stripped[name_idx + 1:name_idx + 4]:
        if re.match(r"(Tiny|Small|Medium|Large|Huge|Gargantuan)", l, re.I):
            type_line = l
            break
    if not type_line:
        return None

    type_m = re.match(
        r"(Tiny|Small|Medium|Large|Huge|Gargantuan)(?:\s+or\s+\w+)?\s+(.*?),\s*(.*)",
        type_line, re.I
    )
    if not type_m:
        return None
    size_raw = type_m.group(1).strip()
    size = size_raw.title()
    creature_type_full = type_m.group(2).strip()
    alignment = type_m.group(3).strip()

    # Extract base type (before parenthetical subtype)
    creature_type = re.sub(r"\s*\(.*\)", "", creature_type_full).strip()

    # AC
    ac = 10
    for l in block_stripped:
        m = re.match(r"AC\s+(\d+)", l)
        if m:
            ac = int(m.group(1))
            break

    # HP
    hp = 1
    hit_dice = ""
    for l in block_stripped:
        m = re.match(r"HP\s+(\d+)\s*\(([^)]+)\)", l)
        if m:
            hp = int(m.group(1))
            hit_dice = m.group(2).strip()
            break

    # Speed
    speed = {"walk": 30}
    for l in block_stripped:
        m = re.match(r"Speed\s+(.+)", l, re.I)
        if m:
            speed = parse_speed(m.group(1))
            break

    # Abilities + saving throws
    abilities, saving_throws = parse_ability_line(block_stripped)

    # Skills
    skills = {}
    for l in block_stripped:
        m = re.match(r"Skills\s+(.+)", l, re.I)
        if m:
            skills = parse_skills(m.group(1))
            break

    # Vulnerabilities
    damage_vulnerabilities = []
    for l in block_stripped:
        m = re.match(r"Vulnerabilities?\s+(.+)", l, re.I)
        if m:
            damage_vulnerabilities = parse_damage_list(m.group(1))
            break

    # Resistances
    damage_resistances = []
    for l in block_stripped:
        m = re.match(r"Resistances?\s+(.+)", l, re.I)
        if m:
            damage_resistances = parse_damage_list(m.group(1))
            break

    # Immunities — can have damage types AND conditions separated by ";"
    damage_immunities = []
    condition_immunities = []
    for l in block_stripped:
        m = re.match(r"Immunities\s+(.+)", l, re.I)
        if m:
            raw = m.group(1)
            # Split on ";" — first part is damage, second is conditions
            parts = raw.split(";")
            if parts:
                damage_immunities = parse_damage_list(parts[0])
            if len(parts) > 1:
                condition_immunities = parse_condition_list(parts[1])
            break

    # Condition Immunities (separate line in some blocks)
    for l in block_stripped:
        m = re.match(r"Condition Immunities\s+(.+)", l, re.I)
        if m:
            condition_immunities = parse_condition_list(m.group(1))
            break

    # Senses
    senses = {}
    for l in block_stripped:
        m = re.match(r"Senses\s+(.+)", l, re.I)
        if m:
            senses = parse_senses(m.group(1))
            break

    # Languages
    languages = None
    for l in block_stripped:
        m = re.match(r"Languages\s+(.*)", l, re.I)
        if m:
            lang = m.group(1).strip()
            languages = lang if lang and lang.lower() not in ("none", "—", "-") else None
            break

    # CR / XP
    cr = "0"
    xp = 0
    proficiency_bonus = 2
    for l in block_stripped:
        m = re.match(r"CR\s+(.+)", l)
        if m:
            cr, xp = parse_cr(m.group(1))
            pb_m = re.search(r"PB\s*\+(\d+)", m.group(1))
            if pb_m:
                proficiency_bonus = int(pb_m.group(1))
            break

    # Sections
    traits = parse_section(block_stripped, "Traits")
    actions = parse_section(block_stripped, "Actions")
    bonus_actions = parse_section(block_stripped, "Bonus Actions")
    reactions = parse_section(block_stripped, "Reactions")
    legendary_actions = parse_section(block_stripped, "Legendary Actions")

    if debug:
        print(f"  Parsed: {name} ({size} {creature_type}) CR{cr} HP{hp} AC{ac}", file=sys.stderr)

    return Creature(
        name=name,
        slug=slugify(name),
        size=size,
        creature_type=creature_type,
        alignment=alignment,
        armor_class=ac,
        hit_points=hp,
        hit_dice=hit_dice,
        speed=speed,
        str_=abilities["str"],
        dex=abilities["dex"],
        con=abilities["con"],
        int_=abilities["int"],
        wis=abilities["wis"],
        cha=abilities["cha"],
        saving_throws=saving_throws,
        skills=skills,
        damage_vulnerabilities=damage_vulnerabilities,
        damage_resistances=damage_resistances,
        damage_immunities=damage_immunities,
        condition_immunities=condition_immunities,
        senses=senses,
        languages=languages,
        challenge_rating=cr,
        xp=xp,
        proficiency_bonus=proficiency_bonus,
        traits=traits,
        actions=actions,
        bonus_actions=bonus_actions,
        reactions=reactions,
        legendary_actions=legendary_actions,
    )


# ---------------------------------------------------------------------------
# SQL generation
# ---------------------------------------------------------------------------

def creature_to_sql(c: Creature) -> str:
    saves_json = sql_jsonb(c.saving_throws)
    speed_json = sql_jsonb(c.speed)
    senses_json = sql_jsonb(c.senses)
    actions_json = sql_jsonb_actions(c.actions)
    bonus_actions_json = sql_jsonb_actions(c.bonus_actions)
    reactions_json = sql_jsonb_actions(c.reactions)
    traits_json = sql_jsonb_actions(c.traits)
    legendary_json = sql_jsonb_actions(c.legendary_actions)
    vulns = sql_array(c.damage_vulnerabilities)
    resists = sql_array(c.damage_resistances)
    dmg_immun = sql_array(c.damage_immunities)
    cond_immun = sql_array(c.condition_immunities)

    return f"""    (
        '{sql_escape(c.slug)}', '{sql_escape(c.name)}',
        '{c.size}', '{sql_escape(c.creature_type)}', '{sql_escape(c.alignment)}',
        {c.armor_class}, {c.hit_points}, '{sql_escape(c.hit_dice)}',
        {speed_json},
        {c.str_}, {c.dex}, {c.con}, {c.int_}, {c.wis}, {c.cha},
        {saves_json},
        {vulns}, {resists}, {dmg_immun}, {cond_immun},
        {senses_json},
        {sql_str(c.languages)},
        '{sql_escape(c.challenge_rating)}', {c.xp}, {c.proficiency_bonus},
        {traits_json}, {actions_json}, {bonus_actions_json},
        {reactions_json}, {legendary_json}
    )"""


def creature_skills_sql(creatures: list[Creature]) -> str:
    rows = []
    for c in creatures:
        for skill, bonus in c.skills.items():
            rows.append(f"    ('{sql_escape(c.slug)}', '{sql_escape(skill)}', {bonus})")
    if not rows:
        return ""
    return (
        "INSERT INTO creature_skills (creature_id, skill_slug, bonus)\n"
        "SELECT c.id, s.skill_slug, s.bonus\n"
        "FROM (\n  VALUES\n"
        + ",\n".join(
            f"    ('{sql_escape(c.slug)}', '{sql_escape(skill)}', {bonus})"
            for c in creatures
            for skill, bonus in c.skills.items()
        )
        + "\n) AS s(creature_slug, skill_slug, bonus)\n"
        "JOIN creatures c ON c.slug = s.creature_slug\n"
        "ON CONFLICT (creature_id, skill_slug) DO UPDATE SET bonus = EXCLUDED.bonus;\n"
    )


def generate_sql(creatures: list[Creature]) -> str:
    columns = """    slug, name,
    size, creature_type, alignment,
    armor_class, hit_points, hit_dice,
    speed,
    str, dex, con, int, wis, cha,
    saving_throws,
    damage_vulnerabilities, damage_resistances, damage_immunities, condition_immunities,
    senses,
    languages,
    challenge_rating, xp, proficiency_bonus,
    traits, actions, bonus_actions, reactions, legendary_actions"""

    rows = [creature_to_sql(c) for c in creatures]

    lines = [
        "-- Auto-generated by parse_srd_creatures.py",
        "-- Source: SRD 5.2.1",
        "-- DO NOT EDIT MANUALLY",
        "",
        "INSERT INTO creatures (",
        columns,
        ") VALUES",
        ",\n".join(rows),
        "ON CONFLICT (slug) DO UPDATE SET",
        "    name                   = EXCLUDED.name,",
        "    size                   = EXCLUDED.size,",
        "    creature_type          = EXCLUDED.creature_type,",
        "    alignment              = EXCLUDED.alignment,",
        "    armor_class            = EXCLUDED.armor_class,",
        "    hit_points             = EXCLUDED.hit_points,",
        "    hit_dice               = EXCLUDED.hit_dice,",
        "    speed                  = EXCLUDED.speed,",
        "    str                    = EXCLUDED.str,",
        "    dex                    = EXCLUDED.dex,",
        "    con                    = EXCLUDED.con,",
        "    int                    = EXCLUDED.int,",
        "    wis                    = EXCLUDED.wis,",
        "    cha                    = EXCLUDED.cha,",
        "    saving_throws          = EXCLUDED.saving_throws,",
        "    damage_vulnerabilities = EXCLUDED.damage_vulnerabilities,",
        "    damage_resistances     = EXCLUDED.damage_resistances,",
        "    damage_immunities      = EXCLUDED.damage_immunities,",
        "    condition_immunities   = EXCLUDED.condition_immunities,",
        "    senses                 = EXCLUDED.senses,",
        "    languages              = EXCLUDED.languages,",
        "    challenge_rating       = EXCLUDED.challenge_rating,",
        "    xp                     = EXCLUDED.xp,",
        "    proficiency_bonus      = EXCLUDED.proficiency_bonus,",
        "    traits                 = EXCLUDED.traits,",
        "    actions                = EXCLUDED.actions,",
        "    bonus_actions          = EXCLUDED.bonus_actions,",
        "    reactions              = EXCLUDED.reactions,",
        "    legendary_actions      = EXCLUDED.legendary_actions;",
        "",
    ]

    skills_sql = creature_skills_sql(creatures)
    if skills_sql:
        lines += ["", skills_sql]

    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description="Parse SRD 5.2.1 creature stat blocks → SQL seed")
    parser.add_argument("--srd", default="docs/srd521.txt", help="Path to srd521.txt")
    parser.add_argument("--out", default="campaign-rpg/tools/creatures_seed.sql", help="Output SQL file")
    parser.add_argument("--debug", action="store_true", help="Print parsing details to stderr")
    args = parser.parse_args()

    srd_path = Path(args.srd)
    if not srd_path.exists():
        # try relative to repo root
        script_dir = Path(__file__).parent
        srd_path = script_dir.parent.parent / "docs" / "srd521.txt"
    if not srd_path.exists():
        print(f"ERROR: srd521.txt not found at {args.srd}", file=sys.stderr)
        sys.exit(1)

    print(f"Reading {srd_path}...", file=sys.stderr)
    lines = srd_path.read_text(encoding="utf-8", errors="replace").splitlines()
    print(f"  {len(lines)} lines", file=sys.stderr)

    print("Finding stat block ranges...", file=sys.stderr)
    ranges = find_stat_block_ranges(lines)
    print(f"  Found {len(ranges)} candidate blocks", file=sys.stderr)

    creatures = []
    skipped = 0
    seen_slugs = set()

    for start, end in ranges:
        c = parse_block(lines, start, end, debug=args.debug)
        if c is None:
            skipped += 1
            continue
        # Skip obvious false positives
        # Names shouldn't have periods, lowercase starts, or be > 50 chars
        if (len(c.name) > 50
                or "." in c.name
                or c.name[0].islower()
                or re.search(r"\b(you|the|it|your|this|that|and|or|can|t |s )", c.name, re.I)
                or c.hit_points <= 1 and c.armor_class <= 10 and not c.actions):
            skipped += 1
            continue
        # Deduplicate by slug — keep first occurrence
        if c.slug in seen_slugs:
            if args.debug:
                print(f"  SKIP duplicate: {c.slug}", file=sys.stderr)
            skipped += 1
            continue
        seen_slugs.add(c.slug)
        creatures.append(c)

    print(f"  Parsed: {len(creatures)} creatures, skipped: {skipped}", file=sys.stderr)

    sql = generate_sql(creatures)

    out_path = Path(args.out)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(sql, encoding="utf-8")
    print(f"Written: {out_path}  ({len(sql)} bytes)", file=sys.stderr)

    # Summary
    print("\nSample creatures parsed:", file=sys.stderr)
    for c in creatures[:10]:
        print(f"  {c.slug:30s}  CR{c.challenge_rating:4s}  HP{c.hit_points:4d}  AC{c.armor_class:3d}  {c.size} {c.creature_type}", file=sys.stderr)

    skills_count = sum(len(c.skills) for c in creatures)
    print(f"\nTotal creature_skills rows: {skills_count}", file=sys.stderr)


if __name__ == "__main__":
    main()
