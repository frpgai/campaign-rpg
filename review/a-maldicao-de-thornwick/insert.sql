-- ============================================================
-- INSERT SEED: A Maldição de Thornwick
-- Gerado contra migrations 000009-000013
--
-- Idempotente:
--   ON CONFLICT DO UPDATE  → tabelas com slug/key único
--   DELETE + reinsert      → scene_creatures, scene_points_of_interest,
--                            npc_dialogue_options, npc_dialogue_conditions
--
-- Modelo gamebook/CYOA:
--   Toda a lógica de branching está declarada aqui.
--   O sistema avalia scene_unlocks e npc_dialogue_conditions
--   no runtime, quando um herói chegar nessa parte do jogo.
--   Nenhum GM humano ou IA decide — apenas esta configuração.
--
-- Variante de cena:
--   Cena 2.3 existe em duas versões:
--   03a (pacífico) — destravada quando herói completa o ritual
--   03b (conflito) — destravada quando herói recusa ou falha
--   O scene_unlock usa trigger_type='dialogue_option' apontando
--   para a npc_dialogue_option específica que determinou o caminho.
--   Os scene_unlocks de dialogue_option ficam ao FINAL do bloco
--   pois o FK exige que npc_dialogue_options já existam (migration 013).
-- ============================================================

DO $main$
DECLARE
  -- campaign
  v_campaign_id    UUID;

  -- adventures
  v_adv1_id        UUID;
  v_adv2_id        UUID;

  -- scenes
  v_scene1_id      UUID;   -- 1.1 A Vila que Respira com Medo
  v_scene2_id      UUID;   -- 1.2 O Que os Mortos Deixaram
  v_scene3_id      UUID;   -- 1.3 A Primeira Noite
  v_scene4_id      UUID;   -- 2.1 O Cemitério que Respira
  v_scene5_id      UUID;   -- 2.2 Os Corredores de Aldric
  v_scene6a_id     UUID;   -- 2.3a O Coração da Maldição (Pacífico)
  v_scene6b_id     UUID;   -- 2.3b O Coração da Maldição (Conflito/Wraith)

  -- campaign_npcs
  v_npc_marta_id   UUID;
  v_npc_henwick_id UUID;
  v_npc_aldric_id  UUID;

  -- scene_npc_dialogues
  v_snd_marta_s1   UUID;   -- Marta em cena 1
  v_snd_henwick_s1 UUID;   -- Henwick em cena 1
  v_snd_henwick_s3 UUID;   -- Henwick em cena 3
  v_snd_aldric_s5  UUID;   -- Aldric em cena 5

  -- dialogue nodes: Marta (cena 1)
  v_m_root    UUID;
  v_m_a       UUID;
  v_m_a1s     UUID;   -- node_a1 sucesso (Persuasion DC 13)
  v_m_a1f     UUID;   -- node_a1 falha
  v_m_a2      UUID;
  v_m_b       UUID;
  v_m_b1      UUID;
  v_m_b2      UUID;
  v_m_c       UUID;
  v_m_close   UUID;

  -- dialogue nodes: Padre Henwick (cena 1)
  v_h1_root   UUID;
  v_h1_a      UUID;
  v_h1_a1     UUID;
  v_h1_a2     UUID;
  v_h1_b      UUID;
  v_h1_b1     UUID;
  v_h1_b2     UUID;
  v_h1_c      UUID;
  v_h1_close  UUID;

  -- dialogue nodes: Padre Henwick (cena 3)
  v_h3_root   UUID;
  v_h3_a      UUID;
  v_h3_b      UUID;
  v_h3_c      UUID;
  v_h3_close  UUID;

  -- dialogue nodes: Aldric / Ghost (cena 5)
  v_ald_root    UUID;
  v_ald_a       UUID;
  v_ald_a1      UUID;
  v_ald_a2      UUID;
  v_ald_b       UUID;
  v_ald_b1      UUID;
  v_ald_b2_rit  UUID;   -- atalho direto ao ritual
  v_ald_c       UUID;
  v_ald_ritual  UUID;
  v_ald_succ    UUID;   -- terminal: ritual completado → cena 6a
  v_ald_flee    UUID;   -- terminal: fantasma foge → cena 6b

  -- IDs de opções terminais (necessários para scene_unlocks dialogue_option)
  -- Nomes descritivos: v_opt_<nó de origem>_<destino>
  v_opt_ritual_done  UUID;   -- opção "completar ritual" em v_ald_ritual → v_ald_succ → cena 6a
  v_opt_b2_done      UUID;   -- opção "iniciar ritual" em v_ald_b2_rit  → v_ald_succ → cena 6a
  v_opt_a1_ritual    UUID;   -- opção "prosseguir" em v_ald_a1          → v_ald_ritual → (depois: cena 6a)
  v_opt_a2_ritual    UUID;   -- opção "prosseguir" em v_ald_a2          → v_ald_ritual → (depois: cena 6a)
  v_opt_b1_ritual    UUID;   -- opção "prosseguir" em v_ald_b1          → v_ald_ritual → (depois: cena 6a)
  v_opt_hostil       UUID;   -- opção "Isso não justifica" em v_ald_c   → v_ald_flee  → cena 6b

  -- creature ids (null se não existir na tabela creatures)
  v_cr_skeleton UUID;
  v_cr_zombie   UUID;
  v_cr_ghost    UUID;
  v_cr_wraith   UUID;

  -- poi ids do catálogo — todos obrigatórios (poi_id NOT NULL per migration 000019)
  -- slugs conforme seed em 000004_create_pois.up.sql
  v_poi_fogueira         UUID; -- extinguished-campfire
  v_poi_celeiro_porta    UUID; -- back-door
  v_poi_poco_central     UUID; -- stone-well
  v_poi_oliveira_runas   UUID; -- arcane-altar (oliveira é o suporte físico do altar arcano)
  v_poi_passagem_secreta UUID; -- false-wall (passagem esculpida de dentro = parede falsa)
  v_poi_fissura_fuga     UUID; -- wall-crack (fissura natural de saída)
  v_poi_altar_arcano     UUID; -- arcane-altar
  v_poi_armadilha        UUID; -- pressure-trap
  v_poi_esqueleto        UUID; -- bones-on-floor
  v_poi_diario           UUID; -- old-tome
  v_poi_lareira          UUID; -- fireplace
  v_poi_estatua          UUID; -- statue
  v_poi_simbolo_arcano   UUID; -- arcane-symbol
  v_poi_bau_trancado     UUID; -- locked-chest

BEGIN

  -- Resolve creature ids por slug
  SELECT id INTO v_cr_skeleton FROM creatures WHERE slug = 'skeleton' LIMIT 1;
  SELECT id INTO v_cr_zombie   FROM creatures WHERE slug = 'zombie'   LIMIT 1;
  SELECT id INTO v_cr_ghost    FROM creatures WHERE slug = 'ghost'    LIMIT 1;
  SELECT id INTO v_cr_wraith   FROM creatures WHERE slug = 'wraith'   LIMIT 1;

  -- Resolve poi ids do catálogo por slug exato (000004 seed)
  SELECT id INTO v_poi_fogueira         FROM pois WHERE slug = 'extinguished-campfire' LIMIT 1;
  SELECT id INTO v_poi_celeiro_porta    FROM pois WHERE slug = 'back-door'             LIMIT 1;
  SELECT id INTO v_poi_poco_central     FROM pois WHERE slug = 'stone-well'            LIMIT 1;
  SELECT id INTO v_poi_oliveira_runas   FROM pois WHERE slug = 'arcane-altar'          LIMIT 1;
  SELECT id INTO v_poi_passagem_secreta FROM pois WHERE slug = 'false-wall'            LIMIT 1;
  SELECT id INTO v_poi_fissura_fuga     FROM pois WHERE slug = 'wall-crack'            LIMIT 1;
  SELECT id INTO v_poi_altar_arcano     FROM pois WHERE slug = 'arcane-altar'          LIMIT 1;
  SELECT id INTO v_poi_armadilha        FROM pois WHERE slug = 'pressure-trap'         LIMIT 1;
  SELECT id INTO v_poi_esqueleto        FROM pois WHERE slug = 'bones-on-floor'        LIMIT 1;
  SELECT id INTO v_poi_diario           FROM pois WHERE slug = 'old-tome'              LIMIT 1;
  SELECT id INTO v_poi_lareira          FROM pois WHERE slug = 'fireplace'             LIMIT 1;
  SELECT id INTO v_poi_estatua          FROM pois WHERE slug = 'statue'                LIMIT 1;
  SELECT id INTO v_poi_simbolo_arcano   FROM pois WHERE slug = 'arcane-symbol'         LIMIT 1;
  SELECT id INTO v_poi_bau_trancado     FROM pois WHERE slug = 'locked-chest'          LIMIT 1;

  -- ==========================================================
  -- CAMPAIGN
  -- ==========================================================
  INSERT INTO campaigns (slug, title, description, intro_narration, cover_image_prompt, status)
  VALUES (
    'a-maldicao-de-thornwick',
    'A Maldição de Thornwick',
    'Libertar a aldeia de Thornwick das criaturas que emergem do cemitério toda noite antes que os sobreviventes sejam consumidos. A maldição é o eco da dor do curandeiro Aldric, exilado décadas atrás — não vilão, mas vítima de uma injustiça que não encontrou nome.',
    'Vocês são viajantes que cruzam os campos do interior, cada um por seus próprios motivos — talvez uma encomenda, talvez uma dívida, talvez simplesmente a estrada que segue em frente. O outono chegou cedo neste ano: as folhas estão caindo antes do tempo, e as noites ficaram frias de uma hora para outra, como se o mundo decidisse pular direto para o inverno.

A aldeia de Thornwick aparece no final de uma tarde cinzenta. Pequena, de pedra escura, com uma torre de igreja e campos de centeio que alguém colheu às pressas. À distância, parece normal. Mas conforme vocês se aproximam, algo pesa no ar — a ausência de fumaça saindo das chaminés, a ausência de crianças, a ausência de qualquer som que não seja o vento. Para quem viaja muito, ausência assim tem um nome: medo.

Na entrada da aldeia há um aviso pregado numa tábua de carvalho, escrito com mão trêmula: "PROIBIDA A SAÍDA APÓS O POR DO SOL. POR ORDEM DO CONSELHO DE THORNWICK." Não há data. Não há assinatura. E não há ninguém para explicar.',
    'A dark medieval village at dusk, fog rolling in from the north. A hilltop cemetery looms in the background, its wrought-iron gate ajar, emanating a sickly greenish-yellow glow from between the gravestones. An ancient gnarled olive tree at the cemetery''s center drips black sap from runes carved into its roots. The village below has shuttered windows, a single dying torch by the well, and doors reinforced with planks. Silhouettes of undead figures can be glimpsed between the headstones. Color palette: deep charcoal, aged gold, blood red, moss green, pale moonlight. Style: atmospheric hand-painted gothic fantasy illustration, detailed and melancholic.',
    'published'
  )
  ON CONFLICT (slug) DO UPDATE SET
    title              = EXCLUDED.title,
    description        = EXCLUDED.description,
    intro_narration    = EXCLUDED.intro_narration,
    cover_image_prompt = EXCLUDED.cover_image_prompt,
    status             = EXCLUDED.status,
    updated_at         = now()
  RETURNING id INTO v_campaign_id;

  -- ==========================================================
  -- CAMPAIGN NPCs
  -- ==========================================================
  INSERT INTO campaign_npcs (campaign_id, slug, name, appearance, personality_ideal, personality_bond, personality_flaw, what_they_know, how_they_act, enabled)
  VALUES (
    v_campaign_id, 'marta', 'Marta',
    'Noventa e poucos anos, pele de pergaminho enrugado, cabelo branco preso num coque apertado com um alfinete de osso. Senta-se com a coluna mais reta que qualquer outro aldeão. Olhos castanhos e claros — enxergam mais do que deveriam.',
    'Os mortos têm direito à memória. Esquecer é uma forma de mentir.',
    'Ela estava presente no exílio de Aldric. Tinha oito anos e não disse nada. Carrega isso há décadas.',
    'Tem medo de que revelar o que sabe destrua o que resta da comunidade. Resiste até ser pressionada com compaixão, não com força.',
    'Lembra de um inverno muito frio, de um homem expulso sob neve, de um nome que todos pararam de dizer. Sabe que o cemitério está se lembrando de algo que a aldeia quis esquecer. Se tratada com gentileza (Persuasion DC 13 ou roleplay convincente), menciona: havia um curandeiro chamado Aldric que morava perto do cemitério.',
    'Fala devagar, escolhendo cada palavra. Não mente — mas omite. Se os heróis forem agressivos, fecha-se completamente. Se forem gentis, abre um palmo a cada pergunta.',
    true
  )
  ON CONFLICT (campaign_id, slug) DO UPDATE SET
    name = EXCLUDED.name, appearance = EXCLUDED.appearance,
    personality_ideal = EXCLUDED.personality_ideal, personality_bond = EXCLUDED.personality_bond,
    personality_flaw = EXCLUDED.personality_flaw, what_they_know = EXCLUDED.what_they_know,
    how_they_act = EXCLUDED.how_they_act, enabled = EXCLUDED.enabled, updated_at = now()
  RETURNING id INTO v_npc_marta_id;

  INSERT INTO campaign_npcs (campaign_id, slug, name, appearance, personality_ideal, personality_bond, personality_flaw, what_they_know, how_they_act, enabled)
  VALUES (
    v_campaign_id, 'padre-henwick', 'Padre Henwick',
    'Cinquenta e tantos anos, barba mal-aparada, olhos vermelhos de noites sem dormir. Veste o hábito pardo da Igreja local sobre uma camisa de lã. Carrega um rosário que repete entre os dedos constantemente.',
    'A fé é o que separa a civilização do caos — mas minha fé está sendo testada.',
    'A igreja é tudo que ele tem. Se a aldeia cair, a igreja cai com ela — e ele não sabe existir fora dela.',
    'Bênçãos não funcionam no cemitério. Isso o aterroriza porque não tem explicação teológica para isso.',
    'Que as bênçãos param de funcionar a menos de 50 metros do cemitério. Que os mortos que levantam são todos enterrados há mais de 30 anos. Que tudo começou na noite seguinte ao enterro do velho Harwick. Que a oliveira do cemitério não perdeu as folhas no outono.',
    'Fala rápido, ansioso. Quer que os heróis resolvam o problema mas também quer supervisionar tudo. Oferece abrigo na igreja. Pode acompanhar até o portão do cemitério, mas não entra.',
    true
  )
  ON CONFLICT (campaign_id, slug) DO UPDATE SET
    name = EXCLUDED.name, appearance = EXCLUDED.appearance,
    personality_ideal = EXCLUDED.personality_ideal, personality_bond = EXCLUDED.personality_bond,
    personality_flaw = EXCLUDED.personality_flaw, what_they_know = EXCLUDED.what_they_know,
    how_they_act = EXCLUDED.how_they_act, enabled = EXCLUDED.enabled, updated_at = now()
  RETURNING id INTO v_npc_henwick_id;

  INSERT INTO campaign_npcs (campaign_id, slug, name, appearance, personality_ideal, personality_bond, personality_flaw, what_they_know, how_they_act, enabled)
  VALUES (
    v_campaign_id, 'aldric', 'Aldric',
    'Translúcido, com leve brilho violeta. Aparenta 50 e poucos anos, com mãos que em vida foram grandes e calosas. Veste roupas simples de curandeiro — avental de couro sobre linho, bolsas de ervas no cinto que não existem mais. Rosto de alguém em paz que não sabe ainda que está em paz.',
    'Eu servi bem. Não peço perdão — peço apenas que se lembrem de que eu existia.',
    'Thornwick era seu lar. Não odeia a aldeia — sente falta dela. A maldição não foi ato de ódio; foi o grito de alguém que não queria ser esquecido.',
    'Não entende completamente o que seu feitiço fez. Pensava que era apenas uma marca de memória. Não sabia que ia animar os mortos.',
    'Sabe o que aconteceu e que a maldição está causando dano, mas não consegue desfazê-la sozinho — o feitiço só se dissolve se alguém pronunciar as palavras de reconhecimento em voz alta no altar da câmara do coração. Condição: dizer seu nome, ler o pergaminho, deixar algo que represente reconhecimento.',
    'Não fala de imediato. Olha. Depois diz em voz muito baixa: "Vocês sabem o nome dele?" — terceira pessoa. Responde à intenção, não à mecânica. Se interpretado como nova rejeição, foge para câmara do coração e se transforma em Wraith.',
    true
  )
  ON CONFLICT (campaign_id, slug) DO UPDATE SET
    name = EXCLUDED.name, appearance = EXCLUDED.appearance,
    personality_ideal = EXCLUDED.personality_ideal, personality_bond = EXCLUDED.personality_bond,
    personality_flaw = EXCLUDED.personality_flaw, what_they_know = EXCLUDED.what_they_know,
    how_they_act = EXCLUDED.how_they_act, enabled = EXCLUDED.enabled, updated_at = now()
  RETURNING id INTO v_npc_aldric_id;

  -- ==========================================================
  -- ADVENTURES
  -- ==========================================================
  INSERT INTO adventures (campaign_id, slug, adventure_type, position, title, description, narrative_role, level_start, level_end)
  VALUES (
    v_campaign_id, '01-as-noites-que-devoram', 'main', 1,
    'As Noites que Devoram',
    'Os heróis chegam à aldeia de Thornwick, investigam a origem dos ataques noturnos de mortos-vivos, descobrem a identidade de Aldric e sobrevivem à primeira noite de combate.',
    'discovery', 1, 2
  )
  ON CONFLICT (campaign_id, slug) DO UPDATE SET
    title = EXCLUDED.title, description = EXCLUDED.description,
    narrative_role = EXCLUDED.narrative_role, position = EXCLUDED.position,
    level_start = EXCLUDED.level_start, level_end = EXCLUDED.level_end, updated_at = now()
  RETURNING id INTO v_adv1_id;

  INSERT INTO adventures (campaign_id, slug, adventure_type, position, title, description, narrative_role, level_start, level_end)
  VALUES (
    v_campaign_id, '02-a-fonte-da-maldicao', 'main', 2,
    'A Fonte da Maldição',
    'Os heróis vão ao cemitério, descobrem a cripta de Aldric, enfrentam seu fantasma — por ritual de reconhecimento ou combate — e desfazem o altar que sustenta a maldição.',
    'climax', 1, 2
  )
  ON CONFLICT (campaign_id, slug) DO UPDATE SET
    title = EXCLUDED.title, description = EXCLUDED.description,
    narrative_role = EXCLUDED.narrative_role, position = EXCLUDED.position,
    level_start = EXCLUDED.level_start, level_end = EXCLUDED.level_end, updated_at = now()
  RETURNING id INTO v_adv2_id;

  -- Adventure unlock
  INSERT INTO adventure_unlocks (from_adventure_id, to_adventure_id, trigger_type)
  VALUES (v_adv1_id, v_adv2_id, 'all_scenes_completed')
  ON CONFLICT (from_adventure_id, to_adventure_id) DO NOTHING;

  -- ==========================================================
  -- SCENES — Capítulo 1
  -- ==========================================================
  INSERT INTO scenes (adventure_id, slug, name, description, map_prompt, rumors_text, transition_text, gm_notes, scene_order)
  VALUES (
    v_adv1_id, '01-a-vila-que-respira-com-medo',
    'A Vila que Respira com Medo',
    'Os heróis chegam a Thornwick — silêncio anormal, portas pregadas, fogueira apagada. Marta senta no banco de pedra como imune ao medo. Padre Henwick aparece na porta da igreja em súplica. Mortos levantam toda noite há três semanas; a resposta está na colina ao norte.',
    'Top-down grid map of a small medieval village square, approximately 30x30 meters. Central feature: an old stone well with a dead torch on a post beside it. Surrounding buildings: a stone church with a reinforced wooden door to the north, a barn with a heavy beam across its door to the east, a row of 3-4 attached stone houses with boarded windows to the south and west. A stone bench near the well where an elderly woman sits. Cobblestone plaza, moss between the stones, a dead fire pit near the well. Overcast sky atmosphere. Style: top-down D&D 5e grid map, hand-drawn aesthetic, muted earth tones with grey stone.',
    'O velho Harwick disse, antes de morrer, que tinha uma coisa na garganta que precisava dizer. Mas morreu antes de dizer. Minha mãe estava lá e ficou acordada três noites com isso na cabeça.

Tem uma casa velha na beira da estrada que sobe pro cemitério. Ninguém entra lá faz uns trinta anos. Dizem que era de um curandeiro que foi embora. Mas curandeiros não "vão embora" — são expulsos ou morrem.

O padre diz que as bênçãos funcionam em tudo menos no cemitério. Mas eu vi ele tentando benzer a porta e a água sagrada secou antes de chegar no portão. Secou. No ar.',
    'Após conversar com Marta e/ou Henwick, os heróis sabem da casa abandonada perto do cemitério. Enquanto o sol ainda está alto, é o melhor momento para ir.',
    'Marta é a chave emocional. Se tratada com desrespeito, fecha-se — Henwick pode mencionar a casa como alternativa. A cena não pode ser bloqueada: os heróis precisam de alguma forma saber da casa.',
    1
  )
  ON CONFLICT (adventure_id, slug) DO UPDATE SET
    name = EXCLUDED.name, description = EXCLUDED.description, map_prompt = EXCLUDED.map_prompt,
    rumors_text = EXCLUDED.rumors_text, transition_text = EXCLUDED.transition_text,
    gm_notes = EXCLUDED.gm_notes, scene_order = EXCLUDED.scene_order, updated_at = now()
  RETURNING id INTO v_scene1_id;

  INSERT INTO scenes (adventure_id, slug, name, description, map_prompt, transition_text, gm_notes, scene_order)
  VALUES (
    v_adv1_id, '02-o-que-os-mortos-deixaram',
    'O Que os Mortos Deixaram',
    'A casa de Aldric fica a 300 metros da praça. Cena investigativa — sem combate. O diário revela quem era Aldric: não antagonista, mas vítima de injustiça. O pergaminho encontrado aqui é o objeto-chave do Capítulo 2.',
    'Top-down grid map of a small stone healer''s cottage interior, approximately 10x8 meters. Main room: a wooden workbench running along the east wall, covered in dried herbs hanging from the ceiling above it. A small fireplace on the north wall with cold ashes. A narrow bed in the northwest corner with a folded blanket. A wooden chair and small table in the center. A locked wooden chest beneath the workbench. One window (boarded from outside, thin slats of light entering). A door to the south (entrance). Style: top-down D&D 5e hand-drawn grid map, muted earthy tones, detailed interior.',
    'Com o diário (e idealmente o pergaminho), os heróis têm o contexto para o que vem. O sol começa a cair. Voltar para a aldeia agora leva à Cena 1.3.',
    'O pergaminho no diário é o objeto-chave do Cap. 2. Investigation DC 10 (deliberadamente baixo). Se não encontrarem aqui, pode aparecer gravado na parede da cripta na Cena 2.2. Quanto mais humano Aldric parecer antes do encontro, mais impactante será aquela cena.',
    2
  )
  ON CONFLICT (adventure_id, slug) DO UPDATE SET
    name = EXCLUDED.name, description = EXCLUDED.description, map_prompt = EXCLUDED.map_prompt,
    transition_text = EXCLUDED.transition_text, gm_notes = EXCLUDED.gm_notes,
    scene_order = EXCLUDED.scene_order, updated_at = now()
  RETURNING id INTO v_scene2_id;

  INSERT INTO scenes (adventure_id, slug, name, description, map_prompt, transition_text, gm_notes, scene_order)
  VALUES (
    v_adv1_id, '03-a-primeira-noite',
    'A Primeira Noite',
    'O sol se foi. Os mortos descem do cemitério pela praça central. Padre Henwick está na porta da igreja com uma tocha — âncora moral dos aldeões. Os heróis decidem onde ficam quando a noite começa.',
    'Top-down grid map of a small medieval village square at night, 30x30 meters. Same layout as Scene 1.1 but in nighttime lighting: deep shadows, a single torch by the church door casting warm orange light in a small radius. Undead approach from the north road. The barn door is reinforced. Style: top-down D&D 5e night encounter map, heavy use of shadows, torch-lit areas in warm amber, dark blues and greys for shadow zones.',
    'Na manhã seguinte, um jovem aldeão diz em voz baixa: "Eu vi. O chão do cemitério se mexeu de dia hoje." Este é o fio que leva ao Capítulo 2.',
    'Esta cena não precisa ser difícil — precisa ser atmosférica. Os mortos são lentos e sem coordenação. Se os heróis tentarem comunicar-se, podem notar (Insight DC 14) que repetem o mesmo gesto — mãos abertas, como quem pede ou oferece algo.',
    3
  )
  ON CONFLICT (adventure_id, slug) DO UPDATE SET
    name = EXCLUDED.name, description = EXCLUDED.description, map_prompt = EXCLUDED.map_prompt,
    transition_text = EXCLUDED.transition_text, gm_notes = EXCLUDED.gm_notes,
    scene_order = EXCLUDED.scene_order, updated_at = now()
  RETURNING id INTO v_scene3_id;

  -- ==========================================================
  -- SCENES — Capítulo 2
  -- ==========================================================
  INSERT INTO scenes (adventure_id, slug, name, description, map_prompt, rumors_text, transition_text, gm_notes, scene_order)
  VALUES (
    v_adv2_id, '01-o-cemiterio-que-respira',
    'O Cemitério que Respira',
    'O portão de ferro cede com um toque. Lápides antigas cobertas de líquen preto, oliveira enorme com seiva negra. Ao norte do tronco, entre as raízes, escada de pedra desce para a cripta de Aldric. Padre Henwick ficou no portão externo.',
    'Top-down grid map of a small rural cemetery, approximately 40x40 meters. Iron gate entrance to the south. Grave markers of various sizes throughout, older and more eroded toward the north section. A massive ancient olive tree at the center-north, its roots spreading visibly above ground. A section of disturbed earth near the olive tree''s north roots indicating a hidden passage. Stone pathways between grave sections, covered in moss. The northern graves show signs of being pushed upward (uneven earth). A low stone wall surrounds the perimeter. Style: top-down D&D 5e grid map, atmospheric, slightly unsettling, muted greens and grey stones with a dark central focus on the olive tree.',
    'Os ossos espalhados no chão da seção norte são restos de mortos-vivos destruídos em noites anteriores, arrastados de volta pelo feitiço ao amanhecer.

A seiva negra da oliveira tem sabor de sal e cinza — como lágrimas velhas. Medicina DC 12: não é veneno, é algo que preserva, não destrói.

Ao pressionar a orelha contra uma lápide antiga em silêncio absoluto, Perception DC 15: palavras em tom muito baixo vindas de baixo da terra. A única palavra distinguível é "Aldric".',
    'A passagem secreta aberta entre as raízes desce para corredor de pedra. A luz que vem de baixo é ligeiramente violeta. Descendo, os heróis entram na Cena 2.2.',
    'Dois ritmos possíveis: combat-first ou exploration-first. O Mestre pode dar pistas visuais sem exigir teste: "as raízes ao norte formam quase um arco sobre o chão". Destruir a oliveira não é possível com ferramentas comuns — ela resiste a dano não-mágico.',
    1
  )
  ON CONFLICT (adventure_id, slug) DO UPDATE SET
    name = EXCLUDED.name, description = EXCLUDED.description, map_prompt = EXCLUDED.map_prompt,
    rumors_text = EXCLUDED.rumors_text, transition_text = EXCLUDED.transition_text,
    gm_notes = EXCLUDED.gm_notes, scene_order = EXCLUDED.scene_order, updated_at = now()
  RETURNING id INTO v_scene4_id;

  INSERT INTO scenes (adventure_id, slug, name, description, map_prompt, rumors_text, transition_text, gm_notes, scene_order)
  VALUES (
    v_adv2_id, '02-os-corredores-de-aldric',
    'Os Corredores de Aldric',
    'Corredor estreito desce 11 degraus até câmara circular — memorial, não lugar de ódio. Ossos dispostos em paz, ervas nas paredes, estatueta de mãos abertas. O fantasma de Aldric emerge quando sente intenção de entender. O caminho tomado aqui determina qual versão da Cena 2.3 os heróis encontrarão.',
    'Top-down grid map of an underground stone chamber, approximately 12x10 meters. A narrow corridor entrance from the south (2 meters wide). The chamber is roughly circular with irregular stone walls. A central stone slab with human remains carefully arranged. Wall niches containing pressed herbs and small clay offerings. A carved stone figure of a robed man with open hands on the north wall. Sparse torch sconces on walls with strange pale torches (bone and beeswax). Subtle magical circle engraved in the floor around the slab. Style: top-down D&D 5e dungeon map, atmospheric, low candlelight effect, warm amber mixed with violet shadows.',
    'Os ossos sobre a laje não estão completos: faltam os ossos das mãos — presos entre as pedras das paredes.

O símbolo arcano no chão é um "círculo de eco" — feitiço de baixa potência que repete experiência emocional. Normalmente inofensivo; combinado com morte violenta de Aldric, tornou-se catalisador da maldição. Arcana DC 12 para identificar.

Na parede leste, atrás de pedra removível (Investigation DC 15), há segundo pergaminho em latim arcaico — fórmula de dissolução do círculo de eco. Equivalente ao pergaminho da casa.',
    'Se ritual completado: Ghost dissolve-se em luz violeta. Os heróis vão à Cena 2.3a (pacífica). Se não apaziguado: Ghost some em direção à câmara mais funda — os heróis encontram a Cena 2.3b (Wraith ativo). A transição de cena é determinada pela opção de diálogo escolhida, não por texto descritivo.',
    'Esta é a cena mais importante. O Mestre deve deixar os heróis liderar o ritual. O Ghost responde à intenção, não à mecânica perfeita. Se um herói tiver histórico de injustiça, este é o momento para tomar a frente organicamente.',
    2
  )
  ON CONFLICT (adventure_id, slug) DO UPDATE SET
    name = EXCLUDED.name, description = EXCLUDED.description, map_prompt = EXCLUDED.map_prompt,
    rumors_text = EXCLUDED.rumors_text, transition_text = EXCLUDED.transition_text,
    gm_notes = EXCLUDED.gm_notes, scene_order = EXCLUDED.scene_order, updated_at = now()
  RETURNING id INTO v_scene5_id;

  -- Cena 2.3a — desfecho pacífico (destravada pelo ritual completado)
  INSERT INTO scenes (adventure_id, slug, name, description, map_prompt, transition_text, gm_notes, scene_order)
  VALUES (
    v_adv2_id, '03a-o-coracao-da-maldicao-pacifico',
    'O Coração da Maldição (Pacífico)',
    'Câmara natural de calcário além de fissura na parede norte. Altar circular de pedra negra ao centro — o mecanismo da maldição. O altar pulsa com luz violeta fraca, como chama morrendo por falta de razão para continuar. A câmara está silenciosa. O ritual é um ato de cuidado: desfazer algo que não deveria existir, com respeito.',
    'Top-down grid map of a natural limestone cavern, approximately 15x12 meters. Irregular walls with water dripping marks. A perfectly flat floor. At the center: a circular black stone altar, approximately 2 meters diameter, with an arcane circle glowing faint violet — dimming. Thin arcane lines run from altar to walls. A narrow crack in the north wall. A pressure plate trap near the entrance (Investigation DC 15). A crack in the southeast wall (escape route, Perception DC 20). Style: top-down D&D 5e dungeon map, natural cave, atmospheric, violet fading light.',
    'Com o altar dissolvido, os heróis emergem no cemitério ao amanhecer. Thornwick começa a abrir as primeiras janelas. Alguém acende uma fogueira na praça central. Desta vez, ela pega. FIM DA CAMPANHA.',
    'Esta cena deve ser sentida como alívio silencioso. Pergunte ao grupo: "O que seu personagem sente ao sair do cemitério?" Esta campanha não tem tesouro dramático — tem uma aldeia que pode dormir de novo, e a memória de um homem que finalmente foi lembrado.',
    3
  )
  ON CONFLICT (adventure_id, slug) DO UPDATE SET
    name = EXCLUDED.name, description = EXCLUDED.description, map_prompt = EXCLUDED.map_prompt,
    transition_text = EXCLUDED.transition_text, gm_notes = EXCLUDED.gm_notes,
    scene_order = EXCLUDED.scene_order, updated_at = now()
  RETURNING id INTO v_scene6a_id;

  -- Cena 2.3b — desfecho conflito/Wraith (destravada pela recusa do ritual)
  INSERT INTO scenes (adventure_id, slug, name, description, map_prompt, transition_text, gm_notes, scene_order)
  VALUES (
    v_adv2_id, '03b-o-coracao-da-maldicao-conflito',
    'O Coração da Maldição (Conflito)',
    'Câmara natural de calcário. A fissura na parede norte está rasgada — bordas de pedra forçadas de dentro para fora. A câmara é fria como poço no inverno. A luz violeta do altar agora é vermelha escura, cor de sangue coagulado. Do centro, a figura que foi Aldric olha para os heróis — mas não há mais reconhecimento nos olhos. Apenas raiva que não encontrou saída por tempo demais.',
    'Top-down grid map of a natural limestone cavern, approximately 15x12 meters. Irregular walls with water dripping marks. A perfectly flat floor. At the center: a circular black stone altar with an arcane circle glowing dark red. The crack in the north wall is forced open wider than before. A pressure plate trap near the entrance (Investigation DC 15). A crack in the southeast wall (escape route, Perception DC 20). Style: top-down D&D 5e dungeon map, natural cave, ominous dark red light at center, cold atmosphere.',
    'O Wraith se dissolve em silêncio absoluto — sem grito final, sem luz dramática. Apenas some. O altar ainda precisa ser desfeito (ritual ainda necessário após o combate). A sensação é de vitória incompleta: os heróis venceram, mas o que venceram era trágico, não vil. FIM DA CAMPANHA.',
    'Mesmo na luta contra o Wraith, um herói pode tentar o ritual no altar durante o combate — exige Concentração (Con DC 15 enquanto recebe dano) e uma rodada completa de ação. Se bem-sucedido, dissolve o altar e o Wraith simultaneamente. Pronunciar "Aldric" durante o combate faz o Wraith hesitar 1 turno (perda de ação).',
    4
  )
  ON CONFLICT (adventure_id, slug) DO UPDATE SET
    name = EXCLUDED.name, description = EXCLUDED.description, map_prompt = EXCLUDED.map_prompt,
    transition_text = EXCLUDED.transition_text, gm_notes = EXCLUDED.gm_notes,
    scene_order = EXCLUDED.scene_order, updated_at = now()
  RETURNING id INTO v_scene6b_id;

  -- ==========================================================
  -- SCENE UNLOCKS — scene_completed (não dependem de dialogue options)
  -- Os unlocks scene5 → scene6a/6b são inseridos ao FINAL do bloco,
  -- após npc_dialogue_options existirem (FK para npc_dialogue_options).
  -- ==========================================================
  INSERT INTO scene_unlocks (from_scene_id, to_scene_id, trigger_type)
  VALUES
    (v_scene1_id, v_scene2_id, 'scene_completed'),
    (v_scene2_id, v_scene3_id, 'scene_completed'),
    (v_scene4_id, v_scene5_id, 'scene_completed')
  ON CONFLICT (from_scene_id, to_scene_id) WHERE trigger_dialogue_option_id IS NULL DO NOTHING;

  -- ==========================================================
  -- SCENE CREATURES
  -- ==========================================================
  DELETE FROM scene_creatures WHERE scene_id IN (v_scene3_id, v_scene4_id, v_scene5_id, v_scene6b_id);

  -- Cena 1.3 — A Primeira Noite
  INSERT INTO scene_creatures (scene_id, creature_id, creature_name, quantity, quantity_mode, quantity_per_player, encounter_type, enabled, notes) VALUES
    (v_scene3_id, v_cr_skeleton, 'Skeleton', 1, 'per_player', 1, 'combat', true, '50 XP/PC. Mortos lentos, sem coordenação. A partir da 3ª rodada, Mestre pode adicionar 1 Skeleton extra por rodada (máx 2 extras).'),
    (v_scene3_id, v_cr_zombie,   'Zombie',   1, 'per_player', 1, 'combat', true, '50 XP/PC. Boss opcional: último zumbi caminha direto para a tocha do Padre Henwick. HP: 22 × num_players.');

  -- Cena 2.1 — O Cemitério que Respira
  INSERT INTO scene_creatures (scene_id, creature_id, creature_name, quantity, quantity_mode, quantity_per_player, encounter_type, enabled, notes) VALUES
    (v_scene4_id, v_cr_skeleton, 'Skeleton', 1, 'per_player', 1, 'combat', true, '50 XP/PC. Últimos da noite anterior ou primeiros a acordar. Movem-se mais devagar que os da Cena 1.3.'),
    (v_scene4_id, v_cr_zombie,   'Zombie',   1, 'per_player', 1, 'combat', true, '50 XP/PC. Barulho perto das lápides antigas pode acordar 1 Skeleton extra por rodada (máx 2).');

  -- Cena 2.2 — Ghost (apenas se não apaziguado — narrative_only indica condição especial)
  INSERT INTO scene_creatures (scene_id, creature_id, creature_name, quantity, quantity_mode, quantity_per_player, encounter_type, enabled, notes) VALUES
    (v_scene5_id, v_cr_ghost, 'Ghost (Aldric)', 1, 'per_player', 1, 'narrative_only', true, '1100 XP/PC. HP: 45 × num_players. Só aparece se heróis recusarem o ritual. Foco em Possession e Horrifying Visage — empurrar para fora, não destruir. A 50% HP, para e pergunta: "Por que vocês não dizem o nome dele?" — última chance.');

  -- Cena 2.3b — Wraith (presente porque herói chegou aqui por recusa)
  INSERT INTO scene_creatures (scene_id, creature_id, creature_name, quantity, quantity_mode, quantity_per_player, encounter_type, enabled, notes) VALUES
    (v_scene6b_id, v_cr_wraith, 'Wraith (Aldric corrompido)', 1, 'per_player', 1, 'narrative_only', true, '1800 XP/PC. HP: 67 × num_players. Não fala, não hesita. Life Drain + Specter de heróis mortos. Pronunciar "Aldric" em voz alta: Wraith hesita 1 turno. Ritual no altar durante combate (Con DC 15): dissolve Wraith simultaneamente.');

  -- ==========================================================
  -- SCENE POINTS OF INTEREST
  -- ==========================================================
  DELETE FROM scene_points_of_interest WHERE scene_id IN (v_scene1_id, v_scene2_id, v_scene3_id, v_scene4_id, v_scene5_id, v_scene6a_id, v_scene6b_id);

  -- Cena 1.1
  INSERT INTO scene_points_of_interest (scene_id, poi_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order) VALUES
    (v_scene1_id, v_poi_fogueira,      'Fogueira apagada na praça',  'ambience', NULL, NULL,
     'A lenha foi posicionada com cuidado — alguém tentou acender várias vezes. Marcas de fósforo por toda a madeira. O medo impediu que ficasse tempo suficiente para a chama pegar.',
     NULL, true, 1),
    (v_scene1_id, v_poi_celeiro_porta, 'Porta do celeiro reforçada', 'object', 'Perception', 15,
     'Além das marcas de garras, no canto inferior direito à altura de uma criança, há marcas diferentes — dedos humanos que empurraram de dentro com força. Nem todos os mortos desta história vieram de fora.',
     'Você vê apenas a porta reforçada e as marcas óbvias de garras.', true, 2),
    (v_scene1_id, v_poi_poco_central,  'Poço central com corda nova','object', 'Investigation', 12,
     'A corda nova tem sangue seco nas fibras perto do nó. Alguém foi ferido enquanto buscava água — mas o ferimento não foi mencionado a ninguém.',
     'Você nota apenas que a corda é nova demais para o resto do poço, coberto de musgo velho.', true, 3);

  -- Cena 1.2
  INSERT INTO scene_points_of_interest (scene_id, poi_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order) VALUES
    (v_scene2_id, v_poi_esqueleto, 'Esqueleto no canto da casa', 'object', 'Investigation', 12,
     'Os ossos têm marcas de artrite severa nas mãos — trabalhador manual enterrado há décadas. Nada de especial: a maldição não escolhe os maus nem os bons, apenas os mortos.',
     'Você vê um esqueleto desarticulado no canto — provavelmente entrou aqui numa das noites passadas e foi destruído por alguém antes.', true, 1),
    (v_scene2_id, v_poi_diario,   'Diário de Aldric (bancada)', 'object', 'Investigation', 10,
     'O diário revela: nome completo de Aldric, história com a aldeia, injustiça do exílio, última entrada sobre ir ao cemitério "antes de partir". Entre as páginas, pergaminho com tradução parcial: "Eu existia. Eu servi. Eu fui esquecido. Que quem ler isto me lembre." Crucial na Cena 2.2.',
     'Você encontra o diário mas não consegue ler a letra cursiva e densa. Consegue apenas identificar que é diário pessoal com datas que cobrem décadas e o nome "Aldric" na primeira página.', true, 2),
    (v_scene2_id, v_poi_lareira,  'Ervas queimadas na lareira', 'ambience', NULL, NULL,
     'Cheiro medicinal — camomila, lavanda, algo mais amargo. Quem viveu aqui queimava suas próprias ervas para purificar o ar. Humaniza o lugar: alguém cuidava daqui.',
     NULL, true, 3);

  -- Cena 1.3
  INSERT INTO scene_points_of_interest (scene_id, poi_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order) VALUES
    (v_scene3_id, v_poi_fogueira,    'Fogueira apagada (noite)', 'ambience', NULL, NULL,
     'De noite, a fogueira apagada torna-se ponto de referência negativa. Os mortos-vivos a contornam ligeiramente, como se a lembrança do calor ainda existisse neles.',
     NULL, true, 1),
    (v_scene3_id, v_poi_bau_trancado,'Baú trancado no celeiro', 'object', 'Investigation', 15,
     'O baú contém: farinha de trigo para duas semanas, um frasco de óleo de lanterna, e — no fundo embrulhado em pano — uma faca de prata sem cabo do ferreiro da aldeia. A faca causa +1d4 dano adicional em mortos-vivos.',
     'Você vê o baú mas não consegue abri-lo sem acordar os aldeões dentro do celeiro.', true, 2);

  -- Cena 2.1
  INSERT INTO scene_points_of_interest (scene_id, poi_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order) VALUES
    (v_scene4_id, v_poi_esqueleto,        'Ossos no chão (seção norte)', 'object', 'Investigation', 10,
     'Fragmentos maiores têm marcas de impacto e marcas de recomposição parcial — o feitiço tentou reanimá-los mesmo após destruídos. Cada esqueleto destruído é um a menos para sempre.',
     'Você vê apenas ossos quebrados espalhados, alguns com armaduras velhas corroídas.', true, 1),
    (v_scene4_id, v_poi_oliveira_runas,   'Altar com runas (tronco da oliveira)', 'object', 'Arcana', 12,
     'Símbolos de vinculação e memória — não de destruição. Aldric criou feitiço de lembrança, não de ataque. A oliveira é âncora física da maldição — destruí-la não resolve nada, a fonte está embaixo.',
     'Você reconhece runas mágicas mas não consegue identificar escola ou propósito. Parecem antigas.', true, 2),
    (v_scene4_id, v_poi_passagem_secreta, 'Passagem secreta entre as raízes', 'hidden_passage', 'Investigation', 20,
     'Você encontra a tampa de pedra entre as raízes, perfeitamente encaixada. Marcas de mãos gravadas nos lados — esculpida de dentro para fora. Abre com Atletismo DC 12.',
     'Você não encontra nada incomum além do solo perturbado.', true, 3);

  -- Cena 2.2
  INSERT INTO scene_points_of_interest (scene_id, poi_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order) VALUES
    (v_scene5_id, v_poi_estatua,       'Estátua de Aldric (mãos abertas)', 'object', 'History', 12,
     'Postura de mãos abertas, palmas para cima — gesto ritual de curandeiros: "ofereço o que tenho". Não é postura de poder. Quem reconhecer ganha vantagem no primeiro teste de interação com o Ghost.',
     'Você vê estatueta tosca de pedra. Parece uma pessoa com os braços estendidos.', true, 1),
    (v_scene5_id, v_poi_simbolo_arcano,'Símbolo arcano no chão', 'ambience', NULL, NULL,
     'O círculo gravado pulsa levemente com luz violeta se você olhar por mais de alguns segundos. É o feitiço respirando — não ameaçador, mais como batimento cardíaco.',
     NULL, true, 2),
    (v_scene5_id, v_poi_esqueleto,     'Ossos de Aldric sobre a laje', 'object', 'Investigation', 10,
     'Entre os ossos, segundo pergaminho dobrado dentro do que foi a caixa torácica. Mesmas palavras do pergaminho da casa, mas escritas de forma mais urgente — letras pressionadas fundo. Parece ser o original. Tem o mesmo efeito no ritual.',
     'Você vê os ossos cuidadosamente dispostos mas não encontra nada além deles.', true, 3);

  -- Cena 2.3a (pacífico)
  INSERT INTO scene_points_of_interest (scene_id, poi_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order) VALUES
    (v_scene6a_id, v_poi_altar_arcano,  'Altar arcano central', 'object', 'Arcana', 15,
     'Feitiço de conjuração de memória, escola rara. Para desfazê-lo: palavras de reconhecimento ditas em voz alta por alguém externo. Com proficiência em Arcana/Religion/Persuasion + pergaminho: sem teste. Sem pergaminho: DC 15. Uma rodada de ação. O altar dissolve-se suavemente.',
     'Você sente o poder no altar mas não consegue discernir como funciona.', true, 1),
    (v_scene6a_id, v_poi_armadilha,     'Armadilha de pressão', 'trap', 'Investigation', 15,
     'Você nota a pedra levemente afundada antes de pisá-la. Pode contorná-la ou desativá-la (Thieves'' Tools DC 12).',
     'O primeiro herói a passar a ativa. Todos a 3 metros: Con DC 12 ou cegos por 1 turno.', true, 2),
    (v_scene6a_id, v_poi_fissura_fuga,  'Fissura de fuga (canto sudeste)', 'hidden_passage', 'Perception', 20,
     'Fissura larga o suficiente para uma pessoa passar de lado. Túnel sobe gradualmente — rota para a superfície, emergindo 50 metros do cemitério.',
     'Você não nota a fissura sem procurar ativamente. Procurando especificamente por saídas, DC cai para 10.', true, 3);

  -- Cena 2.3b (conflito)
  INSERT INTO scene_points_of_interest (scene_id, poi_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order) VALUES
    (v_scene6b_id, v_poi_altar_arcano,  'Altar arcano central (ativo)', 'object', 'Arcana', 15,
     'Mesmo mecanismo da versão pacífica, mas pulsando vermelho escuro. Ainda pode ser desfeito: palavras de reconhecimento, mesmo durante o combate com o Wraith (Concentração, Con DC 15 enquanto recebe dano, 1 rodada). Dissolve altar e Wraith simultaneamente.',
     'Você sente raiva cristalizada no altar — poder que não tem mais propósito além de durar.', true, 1),
    (v_scene6b_id, v_poi_armadilha,     'Armadilha de pressão', 'trap', 'Investigation', 15,
     'Você nota a pedra levemente afundada. Pode contorná-la ou desativá-la (Thieves'' Tools DC 12).',
     'O primeiro herói a passar a ativa. Todos a 3 metros: Con DC 12 ou cegos por 1 turno. Barulho pode alertar o Wraith se ainda não viu os heróis.', true, 2),
    (v_scene6b_id, v_poi_fissura_fuga,  'Fissura de fuga (canto sudeste)', 'hidden_passage', 'Perception', 20,
     'Fissura larga o suficiente para uma pessoa passar de lado. Túnel sobe para a superfície. Rota de fuga viável se o grupo precisar recuar.',
     'Você não nota a fissura sem procurar ativamente. Procurando especificamente, DC cai para 10.', true, 3);

  -- ==========================================================
  -- SCENE NPC DIALOGUES
  -- ==========================================================
  INSERT INTO scene_npc_dialogues (scene_id, campaign_npc_id, sort_order, enabled)
  VALUES (v_scene1_id, v_npc_marta_id, 1, true)
  ON CONFLICT (scene_id, campaign_npc_id) DO UPDATE SET sort_order = EXCLUDED.sort_order, enabled = EXCLUDED.enabled
  RETURNING id INTO v_snd_marta_s1;

  INSERT INTO scene_npc_dialogues (scene_id, campaign_npc_id, sort_order, enabled)
  VALUES (v_scene1_id, v_npc_henwick_id, 2, true)
  ON CONFLICT (scene_id, campaign_npc_id) DO UPDATE SET sort_order = EXCLUDED.sort_order, enabled = EXCLUDED.enabled
  RETURNING id INTO v_snd_henwick_s1;

  INSERT INTO scene_npc_dialogues (scene_id, campaign_npc_id, sort_order, enabled)
  VALUES (v_scene3_id, v_npc_henwick_id, 1, true)
  ON CONFLICT (scene_id, campaign_npc_id) DO UPDATE SET sort_order = EXCLUDED.sort_order, enabled = EXCLUDED.enabled
  RETURNING id INTO v_snd_henwick_s3;

  INSERT INTO scene_npc_dialogues (scene_id, campaign_npc_id, sort_order, enabled)
  VALUES (v_scene5_id, v_npc_aldric_id, 1, true)
  ON CONFLICT (scene_id, campaign_npc_id) DO UPDATE SET sort_order = EXCLUDED.sort_order, enabled = EXCLUDED.enabled
  RETURNING id INTO v_snd_aldric_s5;

  -- ==========================================================
  -- NPC DIALOGUE NODES: MARTA (cena 1.1)
  -- ==========================================================
  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_marta_s1, 'root', 'Chegaram tarde. Mas chegaram. Sente aí — em pé, vocês me cansam os olhos.', true)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text, is_root = EXCLUDED.is_root
  RETURNING id INTO v_m_root;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_marta_s1, 'node_a', 'Os mortos levantam. Toda noite, faz três semanas. Começou depois que enterramos o velho Harwick. Antes disso, nada. Só vida normal e chata como sempre foi.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_m_a;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_marta_s1, 'node_a1_sucesso', 'Havia um curandeiro. Aldric. Morava perto do cemitério. Eu tinha oito anos quando ele foi embora. Nunca mais ninguém disse o nome dele em voz alta.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_m_a1s;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_marta_s1, 'node_a1_falha', 'Não é da conta de ninguém o que Harwick lembrava. Cuida dos mortos primeiro.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_m_a1f;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_marta_s1, 'node_a2', 'O padre tenta. As rezas não chegam lá em cima. Não sei por quê — nunca vi bênção não chegar. Isso me diz que o problema é mais velho que as rezas dele.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_m_a2;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_marta_s1, 'node_b', 'Tenho noventa e um anos. Meu medo ficou no caminho faz tempo. O que me resta é curiosidade — e vergonha de coisas que não dá mais pra consertar.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_m_b;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_marta_s1, 'node_b1', 'De ficar calada quando não deveria. De oito anos sendo pouca idade para fazer a coisa certa. Havia um homem que morava perto do portão do cemitério. Curandeiro. Bom homem. Foi embora num inverno muito frio e ninguém foi atrás.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_m_b1;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_marta_s1, 'node_b2', 'Coisas antigas. Anteriores a vocês. Vão lá pro padre — ele sabe o que começou quando começou, mesmo que não saiba o porquê.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_m_b2;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_marta_s1, 'node_c', 'Eu não preciso de nada de vocês. Sento neste banco há sessenta anos. Sento amanhã também, com mortos ou sem.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_m_c;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_marta_s1, 'closing', 'Olhem para a colina antes de anoitecer. O cemitério fica quieto de dia, mas o chão se mexe lá no fundo. Alguém que está lá dentro ainda quer ser lembrado. Não sei de mais nada.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_m_close;

  DELETE FROM npc_dialogue_options WHERE node_id IN (v_m_root, v_m_a, v_m_a1s, v_m_a1f, v_m_a2, v_m_b, v_m_b1, v_m_b2, v_m_c);

  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order) VALUES
    (v_m_root, 'O que está acontecendo nesta aldeia?',       v_m_a, 1),
    (v_m_root, 'Você não parece assustada como os outros.', v_m_b, 2),
    (v_m_root, 'Precisamos de informações agora. Fale.',    v_m_c, 3);

  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, requires_skill_check, skill, dc, success_node_id, failure_node_id, sort_order) VALUES
    (v_m_a, 'Por que depois de Harwick especificamente?', NULL, true, 'persuasion', 13, v_m_a1s, v_m_a1f, 1);
  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order) VALUES
    (v_m_a, 'Alguém já tentou fazer algo a respeito?', v_m_a2, 2),
    (v_m_a1s, '(continuar)', v_m_close, 1),
    (v_m_a1f, '(continuar)', v_m_close, 1),
    (v_m_a2,  '(continuar)', v_m_close, 1),
    (v_m_b, 'Vergonha de quê?',                     v_m_b1, 1),
    (v_m_b, 'O que deveria ter sido consertado?',   v_m_b2, 2),
    (v_m_b1, '(continuar)', v_m_close, 1),
    (v_m_b2, '(continuar)', v_m_close, 1);
  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, requires_skill_check, skill, dc, success_node_id, failure_node_id, sort_order) VALUES
    (v_m_c, 'Peço desculpas. Podemos conversar com calma?', NULL, true, 'persuasion', 10, v_m_root, NULL, 1);

  -- ==========================================================
  -- NPC DIALOGUE NODES: PADRE HENWICK (cena 1.1)
  -- ==========================================================
  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s1, 'root', 'Graças aos céus. São viajantes? Guerreiros? Precisamos de ajuda — não peço isso com facilidade. Não pedi em quarenta anos de ministério. Mas peço agora.', true)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text, is_root = EXCLUDED.is_root
  RETURNING id INTO v_h1_root;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s1, 'node_a', 'Há três semanas, toda noite, mortos levantam do cemitério ao norte. São nossos mortos — aldeões que conheço pelos nomes nas lápides. Eles descem até a praça, ficam um tempo, e voltam antes do amanhecer. Não atacam com intenção — mas matam por acidente, por força cega. Já perdemos dois.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h1_a;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s1, 'node_a1', 'Funcionam... até certo ponto. No raio da igreja, afasto os mais fracos. Mas a cinquenta metros do portão do cemitério, é como se a água sagrada evaporasse no ar. Nunca vi isso. Não tenho explicação teológica.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h1_a1;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s1, 'node_a2', 'Na noite de três semanas atrás. O dia em que enterramos Harwick — o homem mais velho da aldeia. Tinha noventa e seis anos. Na noite seguinte ao enterro, os mortos levantaram pela primeira vez.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h1_a2;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s1, 'node_b', 'Precisamos que alguém vá ao cemitério — de dia, com calma — e descubra o que está causando isso. Tentei ir. Cheguei até o portão. Ouvi algo debaixo da terra que me fez voltar correndo. Não me orgulho disso, mas é a verdade.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h1_b;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s1, 'node_b1', 'Um som de alguém... contando. Em voz muito baixa. Números, ou palavras em sequência. Não era assustador de início. Foi quando percebi que o som vinha de dentro da terra que corri.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h1_b1;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s1, 'node_b2', 'Há uma oliveira velha no centro do cemitério — muito velha, anterior à aldeia. Os mais antigos diziam que ela estava lá antes de qualquer casa. Nas últimas semanas ela está diferente. As folhas não caíram com o outono. No outono, Padre. Todas as outras árvores perderam as folhas. Ela não.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h1_b2;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s1, 'node_c', 'Talvez. Não sei. Mas meu fracasso ou não, as pessoas desta aldeia precisam de ajuda que eu não consigo dar. Podem ajudar ou não. Se não, peço que partam antes do anoitecer — não quero mais mortes.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h1_c;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s1, 'closing', 'A igreja está aberta. É o único lugar onde estão seguros depois do sol. Voltem aqui antes de anoitecer — com ou sem respostas. Não quero procurá-los amanhã entre as lápides.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h1_close;

  DELETE FROM npc_dialogue_options WHERE node_id IN (v_h1_root, v_h1_a, v_h1_a1, v_h1_a2, v_h1_b, v_h1_b1, v_h1_b2, v_h1_c);

  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order) VALUES
    (v_h1_root, 'O que exatamente está acontecendo aqui?', v_h1_a, 1),
    (v_h1_root, 'Como podemos ajudar?',                    v_h1_b, 2),
    (v_h1_root, 'Isto é trabalho de magia negra. Seu fracasso é esperado.', v_h1_c, 3),
    (v_h1_a, 'Suas bênçãos não funcionam?',               v_h1_a1, 1),
    (v_h1_a, 'Quando exatamente começou?',                v_h1_a2, 2),
    (v_h1_a1, '(continuar)', v_h1_close, 1),
    (v_h1_a2, '(continuar)', v_h1_close, 1),
    (v_h1_b, 'O que você ouviu?',                         v_h1_b1, 1),
    (v_h1_b, 'Tem algo específico que devemos procurar?', v_h1_b2, 2),
    (v_h1_b1, '(continuar)', v_h1_close, 1),
    (v_h1_b2, '(continuar)', v_h1_close, 1),
    (v_h1_c,  '(continuar)', v_h1_close, 1);

  -- ==========================================================
  -- NPC DIALOGUE NODES: PADRE HENWICK (cena 1.3)
  -- ==========================================================
  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s3, 'root', 'Fiquem perto da luz. Os que ficam na sombra... eles vão para os mortos primeiro. Não sei por quê. Talvez seja instinto de ambos os lados.', true)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text, is_root = EXCLUDED.is_root
  RETURNING id INTO v_h3_root;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s3, 'node_a', 'Três semanas. Primeira noite fiquei dentro. Ouvi os gritos de fora e não consegui. Na segunda, vim pra soleira. Fiquei aqui desde então.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h3_a;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s3, 'node_b', 'Na segunda semana, um deles parou na praça e ficou parado por quase uma hora, no mesmo lugar. Como se estivesse esperando. Depois voltou. Os outros se movem, circulam. Aquele ficou parado.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h3_b;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s3, 'node_c', 'Esta tocha não é pra mim. É pra quem está dentro. Se ela apagar, eles entram em pânico. Enquanto eu segurar, eles aguentam.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h3_c;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_henwick_s3, 'closing', 'Aqui vêm eles. Deus nos proteja — e vocês também, seja quem for que vocês acreditem que protege viajantes.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_h3_close;

  DELETE FROM npc_dialogue_options WHERE node_id IN (v_h3_root, v_h3_a, v_h3_b, v_h3_c);

  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order) VALUES
    (v_h3_root, 'Quanto tempo você faz isso — ficar aqui toda noite?', v_h3_a, 1),
    (v_h3_root, 'Alguma coisa diferente nas noites anteriores?',        v_h3_b, 2),
    (v_h3_root, 'Você deveria entrar. Deixa com a gente.',              v_h3_c, 3),
    (v_h3_a, '(continuar)', v_h3_close, 1),
    (v_h3_b, '(continuar)', v_h3_close, 1),
    (v_h3_c, '(continuar)', v_h3_close, 1);

  -- ==========================================================
  -- NPC DIALOGUE NODES: ALDRIC / GHOST (cena 2.2)
  -- Atenção: as opções terminais têm seus IDs capturados em
  -- v_opt_* para uso nos scene_unlocks de dialogue_option abaixo.
  -- ==========================================================
  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'root', 'Vocês sabem o nome dele?', true)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text, is_root = EXCLUDED.is_root
  RETURNING id INTO v_ald_root;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'node_a', 'Faz muito tempo que ninguém disse. Vocês vieram da aldeia?', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_ald_a;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'node_a1', 'Eu sei. Não era para ser assim. Eu queria apenas... que alguém se lembrasse. O feitiço era para memória. Não para isto. Eu não sabia que a dor podia fazer isso.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_ald_a1;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'node_a2', 'Quem contou? Não importa. Que alguém saiba... já é mais do que eu esperava encontrar aqui.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_ald_a2;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'node_b', 'Fui exilado. Sim. Mas antes fui curandeiro. Às vezes esqueço nessa ordem.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_ald_b;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'node_b1', 'O diário ainda estava lá. Então vocês sabem da criança. Do inverno. De Harwick. Vocês vieram terminar isso?', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_ald_b1;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'node_b2_ritual', 'Então está na hora. Digam as palavras aqui, neste lugar, com intenção. Não como fórmula — como verdade.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_ald_b2_rit;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'node_c', 'Inocentes. Eles enterraram um homem inocente no frio.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_ald_c;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'node_ritual', 'Digam o nome em voz alta. Leiam as palavras do pergaminho: "Você existia. Você serviu. Você foi esquecido. Nós lembramos." Depois deixem algo aqui — qualquer coisa, com intenção.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_ald_ritual;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'node_success', 'Obrigado. Cuide da oliveira. Arranca-a vai quebrar o feitiço. Deixa ela onde está — ela vai morrer sozinha agora.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_ald_succ;

  INSERT INTO npc_dialogue_nodes (scene_npc_dialogue_id, node_key, text, is_root)
  VALUES (v_snd_aldric_s5, 'node_flee', 'Aldric levanta as mãos — não em ameaça, em desespero — e some pela parede com um som de vento em fissura estreita. A câmara fica fria de repente.', false)
  ON CONFLICT (scene_npc_dialogue_id, node_key) DO UPDATE SET text = EXCLUDED.text
  RETURNING id INTO v_ald_flee;

  -- OPTIONS: ALDRIC
  DELETE FROM npc_dialogue_options WHERE node_id IN (
    v_ald_root, v_ald_a, v_ald_a1, v_ald_a2,
    v_ald_b, v_ald_b1, v_ald_b2_rit, v_ald_c, v_ald_ritual
  );

  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order) VALUES
    (v_ald_root, '"Aldric."',                                      v_ald_a,    1),
    (v_ald_root, '"Você é Aldric. O curandeiro que foi exilado."', v_ald_b,    2),
    (v_ald_root, '"Você precisa parar. Está machucando inocentes."', v_ald_c,  3);

  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order) VALUES
    (v_ald_a, '"Sim. Eles estão com medo. Os mortos estão levantando."',     v_ald_a1, 1),
    (v_ald_a, '"Sabemos o que aconteceu com você. A expulsão, o inverno."',  v_ald_a2, 2);

  -- Opções que levam ao ritual → capturam IDs para scene_unlock → cena 6a
  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order)
  VALUES (v_ald_a1, '(prosseguir para o ritual)', v_ald_ritual, 1)
  RETURNING id INTO v_opt_a1_ritual;

  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order)
  VALUES (v_ald_a2, '(prosseguir para o ritual)', v_ald_ritual, 1)
  RETURNING id INTO v_opt_a2_ritual;

  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order) VALUES
    (v_ald_b, '"Encontramos seu diário. Lemos sua história."',   v_ald_b1,    1),
    (v_ald_b, '"Encontramos o pergaminho com suas palavras."',   v_ald_b2_rit, 2);

  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order)
  VALUES (v_ald_b1, '(prosseguir para o ritual)', v_ald_ritual, 1)
  RETURNING id INTO v_opt_b1_ritual;

  -- Atalho direto ao node_success (b2) → captura ID → cena 6a
  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order)
  VALUES (v_ald_b2_rit, '(iniciar ritual)', v_ald_succ, 1)
  RETURNING id INTO v_opt_b2_done;

  -- Opção hostil → node_flee → cena 6b
  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, requires_skill_check, skill, dc, success_node_id, failure_node_id, sort_order)
  VALUES (v_ald_c, '"Você tem razão. O que fizeram foi injusto."', NULL, true, 'insight', 10, v_ald_a1, v_ald_flee, 1);

  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order)
  VALUES (v_ald_c, '"Isso não justifica o que você está fazendo."', v_ald_flee, 2)
  RETURNING id INTO v_opt_hostil;

  -- Opção terminal do ritual → node_success → cena 6a
  INSERT INTO npc_dialogue_options (node_id, label, next_node_id, sort_order)
  VALUES (v_ald_ritual, '(completar o ritual — dizer o nome, ler o pergaminho, deixar um objeto)', v_ald_succ, 1)
  RETURNING id INTO v_opt_ritual_done;

  -- ==========================================================
  -- NPC DIALOGUE CONDITIONS
  -- A opção "completar o ritual" exige que o herói tenha o
  -- pergaminho no inventário. O sistema avalia esta condição
  -- no runtime — a campanha apenas declara o requisito.
  -- (Condição ativada quando spec/00160-inventario estiver
  --  implementado e o item pergaminho-de-aldric existir.)
  -- ==========================================================
  DELETE FROM npc_dialogue_conditions WHERE option_id = v_opt_ritual_done;

  INSERT INTO npc_dialogue_conditions (option_id, condition_type, condition_value)
  VALUES (
    v_opt_ritual_done,
    'has_item',
    '{"item_slug": "pergaminho-de-aldric", "quantity": 1}'::jsonb
  );

  -- ==========================================================
  -- SCENE UNLOCKS — dialogue_option
  -- Inseridos aqui, ao final, pois dependem dos IDs de
  -- npc_dialogue_options (FK adicionado na migration 000013).
  --
  -- Lógica de branching da cena 2.2 → 2.3:
  --   Qualquer opção que leve ao node_ritual/node_success → cena 6a (pacífico)
  --   Opção hostil direta → node_flee → cena 6b (conflito)
  -- ==========================================================

  -- Caminhos para cena 6a (pacífico): 4 opções que levam ao ritual
  INSERT INTO scene_unlocks (from_scene_id, to_scene_id, trigger_type, trigger_dialogue_option_id)
  VALUES
    (v_scene5_id, v_scene6a_id, 'dialogue_option', v_opt_a1_ritual),
    (v_scene5_id, v_scene6a_id, 'dialogue_option', v_opt_a2_ritual),
    (v_scene5_id, v_scene6a_id, 'dialogue_option', v_opt_b1_ritual),
    (v_scene5_id, v_scene6a_id, 'dialogue_option', v_opt_b2_done),
    (v_scene5_id, v_scene6a_id, 'dialogue_option', v_opt_ritual_done)
  ON CONFLICT (from_scene_id, to_scene_id, trigger_dialogue_option_id) DO NOTHING;

  -- Caminho para cena 6b (conflito): opção hostil direta
  INSERT INTO scene_unlocks (from_scene_id, to_scene_id, trigger_type, trigger_dialogue_option_id)
  VALUES (v_scene5_id, v_scene6b_id, 'dialogue_option', v_opt_hostil)
  ON CONFLICT (from_scene_id, to_scene_id, trigger_dialogue_option_id) DO NOTHING;

END $main$;
