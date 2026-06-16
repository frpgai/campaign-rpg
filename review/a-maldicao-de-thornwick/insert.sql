-- ============================================================
-- A Maldição do Curandeiro de Thornwick — INSERT COMPLETO
-- Gerado em 2026-06-16
-- Creatures já existentes no banco:
--   Skeleton : 6af13b8a-59e1-4c3c-94e1-b9ce480023e5
--   Zombie   : 098a68b8-e942-4d4f-88bd-97ca610f7526
--   Ghost    : feea8002-b3b2-4f2c-abda-b13d9e6314ec
--   Wraith   : 09d61d20-c33a-4066-8bf0-d6b75d46ec18
-- ============================================================

DO $$
DECLARE
  -- IDs de criaturas existentes
  v_skeleton_id   UUID := '6af13b8a-59e1-4c3c-94e1-b9ce480023e5';
  v_zombie_id     UUID := '098a68b8-e942-4d4f-88bd-97ca610f7526';
  v_ghost_id      UUID := 'feea8002-b3b2-4f2c-abda-b13d9e6314ec';
  v_wraith_id     UUID := '09d61d20-c33a-4066-8bf0-d6b75d46ec18';

  -- Campaign
  v_campaign_id   UUID := gen_random_uuid();

  -- Adventures
  v_adv1_id       UUID := gen_random_uuid();
  v_adv2_id       UUID := gen_random_uuid();

  -- Scenes cap1
  v_s1_1_id       UUID := gen_random_uuid();
  v_s1_2_id       UUID := gen_random_uuid();
  v_s1_3_id       UUID := gen_random_uuid();

  -- Scenes cap2
  v_s2_1_id       UUID := gen_random_uuid();
  v_s2_2_id       UUID := gen_random_uuid();
  v_s2_3_id       UUID := gen_random_uuid();

  -- NPCs
  v_marta_id      UUID := gen_random_uuid();
  v_henwick_id    UUID := gen_random_uuid();
  v_aldric_id     UUID := gen_random_uuid();

  -- Dialogue nodes — Marta
  v_m_root        UUID := gen_random_uuid();
  v_m_a           UUID := gen_random_uuid();
  v_m_a1          UUID := gen_random_uuid();
  v_m_a1_ok       UUID := gen_random_uuid();
  v_m_a2          UUID := gen_random_uuid();
  v_m_b           UUID := gen_random_uuid();
  v_m_b1          UUID := gen_random_uuid();
  v_m_b2          UUID := gen_random_uuid();
  v_m_c           UUID := gen_random_uuid();
  v_m_end         UUID := gen_random_uuid();

  -- Dialogue nodes — Padre Henwick
  v_h_root        UUID := gen_random_uuid();
  v_h_a           UUID := gen_random_uuid();
  v_h_a1          UUID := gen_random_uuid();
  v_h_a2          UUID := gen_random_uuid();
  v_h_b           UUID := gen_random_uuid();
  v_h_b1          UUID := gen_random_uuid();
  v_h_b2          UUID := gen_random_uuid();
  v_h_c           UUID := gen_random_uuid();
  v_h_end         UUID := gen_random_uuid();

  -- Dialogue nodes — Ghost de Aldric
  v_g_root        UUID := gen_random_uuid();
  v_g_a           UUID := gen_random_uuid();
  v_g_a1          UUID := gen_random_uuid();
  v_g_a2          UUID := gen_random_uuid();
  v_g_b           UUID := gen_random_uuid();
  v_g_b1          UUID := gen_random_uuid();
  v_g_b2          UUID := gen_random_uuid();
  v_g_c           UUID := gen_random_uuid();
  v_g_ritual      UUID := gen_random_uuid();

BEGIN

-- ============================================================
-- 1. CAMPAIGN
-- ============================================================
INSERT INTO campaigns (id, owner_id, title, description, status)
VALUES (
  v_campaign_id,
  NULL,
  'A Maldição do Curandeiro de Thornwick',
  'Liberte a aldeia de Thornwick das criaturas que emergem do cemitério toda noite antes que os sobreviventes sejam consumidos. A maldição de Aldric — força autônoma sem consciência, eco da dor e raiva do curandeiro morto — anima os mortos do cemitério e se espalhará para vilas vizinhas pelo rio subterrâneo se não for desfeita.',
  'draft'
);

-- ============================================================
-- 2. ADVENTURES
-- ============================================================
INSERT INTO adventures (id, campaign_id, position, title, description, narrative_role, level_start, level_end, adventure_type)
VALUES
(
  v_adv1_id,
  v_campaign_id,
  1,
  'Capítulo 1: As Noites que Devoram',
  'Os heróis chegam a Thornwick e encontram uma aldeia sitiada pelo medo. Portas pregadas, janelas tapadas, mortos levantando toda noite do cemitério ao norte. Neste capítulo descobrem a identidade e motivação de Aldric — o curandeiro exilado cuja dor se tornou maldição — e sobrevivem à primeira noite de combate com os mortos-vivos.',
  'discovery',
  1,
  1,
  'main'
),
(
  v_adv2_id,
  v_campaign_id,
  2,
  'Capítulo 2: A Fonte da Maldição',
  'Os heróis adentram o cemitério de Thornwick e descem à cripta que Aldric escavou antes de morrer. Lá encontram seu fantasma e podem apaziguá-lo com reconhecimento e compaixão — ou enfrentar a dor cristalizada em raiva pura na forma de um Wraith. A resolução encerra a maldição e permite que Thornwick respire novamente.',
  'climax',
  1,
  2,
  'main'
);

-- ============================================================
-- 3. SCENES — Capítulo 1
-- ============================================================
INSERT INTO scenes (id, adventure_id, name, description, scene_order)
VALUES
(
  v_s1_1_id,
  v_adv1_id,
  'A Vila que Respira com Medo',
  'Os heróis chegam a Thornwick e encontram silêncio anormal. Portas pregadas, janelas tapadas, fogueira apagada na praça central. A anciã Marta senta impassível no seu banco de pedra. O Padre Henwick suplica ajuda na porta da igreja. Esta é a cena de estabelecimento: os heróis aprendem o que está acontecendo e recolhem os primeiros indícios investigativos — especialmente sobre a casa abandonada perto do cemitério.',
  1
),
(
  v_s1_2_id,
  v_adv1_id,
  'O Que os Mortos Deixaram',
  'A casa de Aldric fica a trezentos metros da praça, onde a estrada começa a subir ao cemitério. Ninguém entrou há mais de trinta anos. Cena investigativa sem combate: os heróis encontram o diário de Aldric e o pergaminho com palavras arcanas de reconhecimento — objeto-chave para apaziguar o fantasma na Cena 2.2.',
  2
),
(
  v_s1_3_id,
  v_adv1_id,
  'A Primeira Noite',
  'O sol se foi. Thornwick muda de forma com a escuridão. Do cemitério, vem o som de terra se abrindo. Os mortos descem a colina pela mesma rua, atraídos pela memória muscular. Primeiro confronto com os mortos-vivos — confirma empiricamente o problema e estabelece a escala: eles vêm toda noite. Sobreviver é requisito para que os aldeões confiem nos heróis.',
  3
);

-- ============================================================
-- 4. SCENES — Capítulo 2
-- ============================================================
INSERT INTO scenes (id, adventure_id, name, description, scene_order)
VALUES
(
  v_s2_1_id,
  v_adv2_id,
  'O Cemitério que Respira',
  'O cemitério de Thornwick é menor do que parece de longe. A oliveira ao centro domina o espaço — seiva negra escorre de runas gravadas na casca, o chão ao redor de suas raízes está quente ao toque. Os heróis confirmam que a maldição tem fonte física e descobrem a entrada da cripta entre as raízes da oliveira.',
  1
),
(
  v_s2_2_id,
  v_adv2_id,
  'Os Corredores de Aldric',
  'A escada de pedra desce onze degraus para um corredor estreito que leva a uma câmara circular. No centro, sobre uma laje de pedra, os ossos de Aldric estão dispostos como se dormissem. Nas paredes, ervas prensadas ainda têm cor décadas depois. O fantasma de Aldric existe aqui — emerge quando sente que os heróis chegaram com intenção de entender. Confronto central: emocional ou físico, dependendo das escolhas.',
  2
),
(
  v_s2_3_id,
  v_adv2_id,
  'O Coração da Maldição',
  'Além da câmara dos ossos, uma cavidade natural de calcário abriga o altar do feitiço de memória de Aldric. Se o Ghost foi apaziguado, os heróis chegam a um lugar silencioso onde o ritual é um ato de cuidado. Se não foi, chegam a uma câmara onde a raiva de Aldric cristalizada os espera como Wraith — dor sem esperança de ser ouvida.',
  3
);

-- ============================================================
-- 5. NPCs
-- ============================================================
INSERT INTO npcs (id, campaign_id, slug, name, description, personality_ideal, personality_bond, personality_flaw, enabled)
VALUES
(
  v_marta_id,
  v_campaign_id,
  'marta-thornwick',
  'Marta',
  'Noventa e um anos, pele de pergaminho enrugado, cabelo branco preso num coque com alfinete de osso. Coluna mais reta que qualquer outro aldeão. Olhos castanhos e claros que enxergam mais do que deveriam. Senta no banco de pedra da praça há sessenta anos e não parou por causa dos mortos.',
  'Os mortos têm direito à memória. Esquecer é uma forma de mentir.',
  'Estava presente no exílio de Aldric. Tinha oito anos e não disse nada. Carrega isso há décadas.',
  'Tem medo de que revelar o que sabe destrua o que resta da comunidade. Resiste até ser pressionada com compaixão, não com força.',
  true
),
(
  v_henwick_id,
  v_campaign_id,
  'padre-henwick',
  'Padre Henwick',
  'Cinquenta e tantos anos, barba mal-aparada, olhos vermelhos de noites sem dormir. Hábito pardo da Igreja local sobre camisa de lã. Carrega rosário que repete entre os dedos constantemente. Fala rápido, ansioso.',
  'A fé é o que separa a civilização do caos — mas minha fé está sendo testada.',
  'A igreja é tudo que ele tem. Se a aldeia cair, a igreja cai com ela.',
  'Bênçãos não funcionam no cemitério. Isso o aterroriza porque não tem explicação teológica.',
  true
),
(
  v_aldric_id,
  v_campaign_id,
  'ghost-aldric',
  'Ghost de Aldric',
  'Translúcido, com leve brilho violeta. Aparenta cinquenta e poucos anos, com mãos grandes e calosas de uma vida de trabalho. Veste roupas simples de curandeiro — avental de couro sobre linho, bolsas de ervas no cinto que não existem mais. Rosto de alguém em paz que não sabe ainda que está em paz.',
  'Eu servi bem. Não peço perdão — peço apenas que se lembrem de que eu existia.',
  'Thornwick era seu lar. Não odeia a aldeia — sente falta dela. A maldição não foi ato de ódio; foi grito de alguém que não queria ser esquecido.',
  'Não entende completamente o que seu feitiço fez. Pensava que era apenas uma marca de memória. Quando os heróis explicam, seu rosto muda.',
  true
);

-- ============================================================
-- 6. SCENE CREATURES
-- ============================================================

-- Cena 1.3 — A Primeira Noite
INSERT INTO scene_creatures (id, scene_id, creature_id, creature_name, quantity, quantity_mode, quantity_per_player, encounter_type, enabled, notes)
VALUES
(
  gen_random_uuid(), v_s1_3_id, v_skeleton_id, 'Skeleton', 0, 'per_player', 1, 'combat', true,
  '50 XP/PC. Movem-se sem urgência, sem coordenação, sem estratégia. Perigo vem do número crescente — Mestre pode adicionar 1 extra por rodada após a terceira (opcional).'
),
(
  gen_random_uuid(), v_s1_3_id, v_zombie_id, 'Zombie', 0, 'per_player', 1, 'combat', true,
  '50 XP/PC. Boss Zombie opcional (onda final): HP 22×num_players, XP 50×num_players. Ignora outros alvos e caminha diretamente para a tocha do Padre Henwick.'
);

-- Cena 2.1 — O Cemitério que Respira
INSERT INTO scene_creatures (id, scene_id, creature_id, creature_name, quantity, quantity_mode, quantity_per_player, encounter_type, enabled, notes)
VALUES
(
  gen_random_uuid(), v_s2_1_id, v_skeleton_id, 'Skeleton', 0, 'per_player', 1, 'combat', true,
  '50 XP/PC. Últimos da noite anterior que não retornaram, ou primeiros a acordar precocemente. Movem-se mais devagar — como sonolentos. Barulho perto das lápides antigas pode acordar 1 Skeleton extra por rodada (máx 2, opcional).'
),
(
  gen_random_uuid(), v_s2_1_id, v_zombie_id, 'Zombie', 0, 'per_player', 1, 'combat', true,
  '50 XP/PC.'
);

-- Cena 2.2 — Os Corredores de Aldric (Ghost — narrative_only)
INSERT INTO scene_creatures (id, scene_id, creature_id, creature_name, quantity, quantity_mode, quantity_per_player, encounter_type, enabled, notes)
VALUES
(
  gen_random_uuid(), v_s2_2_id, v_ghost_id, 'Ghost (Aldric)', 0, 'per_player', 1, 'narrative_only', true,
  '1100 XP/PC se combate; 1100 XP/PC equivalente se apaziguado por roleplay (mesmo valor — deliberado). HP: 45×num_players. Só hostil se heróis recusarem ritual. Foca em Possession e Horrifying Visage. A 50% HP pergunta: "Por que vocês não dizem o nome dele?" — última chance de apaziguamento antes de fugir para 2.3.'
);

-- Cena 2.3 — O Coração da Maldição (Wraith — narrative_only, só se Ghost não apaziguado)
INSERT INTO scene_creatures (id, scene_id, creature_id, creature_name, quantity, quantity_mode, quantity_per_player, encounter_type, enabled, notes)
VALUES
(
  gen_random_uuid(), v_s2_3_id, v_wraith_id, 'Wraith (Aldric corrompido)', 0, 'per_player', 1, 'narrative_only', true,
  '1800 XP/PC. SÓ aparece se Ghost não foi apaziguado em 2.2. HP: 67×num_players. Não fala, não hesita. Ponto de fraqueza: pronunciar "Aldric" durante combate (sem teste) faz o Wraith hesitar 1 turno. Ritual no altar durante combate (Con DC 15 sob dano, 1 rodada de ação) dissolve altar e Wraith simultaneamente. Cena pacífica: 0 XP combate + 500 XP/PC bônus narrativo sugerido.'
);

-- ============================================================
-- 7. SCENE POINTS OF INTEREST
-- ============================================================

-- Cena 1.1 — A Vila que Respira com Medo
INSERT INTO scene_points_of_interest (id, scene_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order)
VALUES
(
  gen_random_uuid(), v_s1_1_id,
  'Fogueira apagada', 'ambience', 'Perception', NULL,
  'Você nota que a lenha foi posicionada com cuidado — alguém tentou acender, várias vezes. As marcas de fósforo estão por toda a madeira. O medo impediu que alguém ficasse tempo suficiente para a chama pegar.',
  NULL, true, 1
),
(
  gen_random_uuid(), v_s1_1_id,
  'Porta do celeiro', 'object', 'Perception', 15,
  'Além das marcas de garras na madeira, você vê algo mais: no canto inferior direito, a altura de uma criança, há uma marca diferente — dedos humanos que empurraram de dentro com força. Nem todos os mortos desta história vieram de fora.',
  'Você vê apenas a porta reforçada e as marcas óbvias de garras.',
  true, 2
),
(
  gen_random_uuid(), v_s1_1_id,
  'Poço central', 'object', 'Investigation', 12,
  'A corda nova no poço tem sangue seco nas fibras, perto do nó. Alguém foi ferido enquanto buscava água — mas o ferimento não foi mencionado a ninguém.',
  'Você nota apenas que a corda é nova demais para o resto do poço, que está coberto de musgo velho.',
  true, 3
);

-- Cena 1.2 — O Que os Mortos Deixaram
INSERT INTO scene_points_of_interest (id, scene_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order)
VALUES
(
  gen_random_uuid(), v_s1_2_id,
  'Corpo do morto (morto-vivo caído)', 'object', 'Investigation', 12,
  'Você examina os ossos e percebe que este esqueleto tem marcas de artrite severa nas mãos — era um trabalhador manual, provavelmente um aldeão comum enterrado há décadas. Não há nada de especial nele, o que torna a maldição mais perturbadora: ela não escolhe os maus nem os bons, apenas os mortos.',
  'Você vê um esqueleto desarticulado no canto — provavelmente entrou aqui numa das noites passadas e foi destruído por alguém antes.',
  true, 1
),
(
  gen_random_uuid(), v_s1_2_id,
  'Diário de Aldric', 'object', 'Investigation', 10,
  'O diário revela: o nome completo de Aldric, sua história com a aldeia, a injustiça do exílio, e a última entrada sobre ir ao cemitério "antes de partir". Entre as páginas, você encontra um pergaminho com palavras arcanas anotadas com tradução parcial — fragmento de ritual de memória. Este pergaminho será crucial na Cena 2.2.',
  'Você encontra o diário mas não consegue ler a letra — é cursiva e densa. Consegue apenas identificar que é um diário pessoal com datas que cobrem décadas e o nome "Aldric" na primeira página.',
  true, 2
),
(
  gen_random_uuid(), v_s1_2_id,
  'Ervas queimadas na lareira', 'ambience', 'Perception', NULL,
  'O cheiro das cinzas é medicinal — camomila, lavanda, algo mais amargo que você não identifica. Quem quer que tenha vivido aqui não queimava lenha comum: queimava suas próprias ervas para purificar o ar. É um detalhe pequeno, mas humaniza o lugar: alguém cuidava daqui.',
  NULL, true, 3
);

-- Cena 1.3 — A Primeira Noite
INSERT INTO scene_points_of_interest (id, scene_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order)
VALUES
(
  gen_random_uuid(), v_s1_3_id,
  'Fogueira apagada (noturna)', 'ambience', 'Perception', NULL,
  'De noite, a fogueira apagada na praça se torna um ponto de referência negativa — a ausência de luz onde deveria haver. Você nota que os mortos-vivos a contornam ligeiramente, como se a lembrança do calor ainda existisse neles.',
  NULL, true, 1
),
(
  gen_random_uuid(), v_s1_3_id,
  'Baú trancado no celeiro', 'object', 'Investigation', 15,
  'O baú contém: farinha de trigo para duas semanas, um frasco de óleo de lanterna, e — no fundo, embrulhado em pano — uma faca de prata sem cabo que pertencia ao ferreiro da aldeia. A faca de prata causa +1d4 de dano adicional em mortos-vivos.',
  'Você vê o baú mas não consegue abri-lo sem acordar os aldeões dentro do celeiro.',
  true, 2
);

-- Cena 2.1 — O Cemitério que Respira
INSERT INTO scene_points_of_interest (id, scene_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order)
VALUES
(
  gen_random_uuid(), v_s2_1_id,
  'Ossos no chão', 'object', 'Investigation', 10,
  'Estes ossos estão parcialmente mágicos — você nota que os fragmentos maiores têm marcas de impacto (golpes de arma) mas também marcas de recomposição parcial, como se o feitiço tentasse reanimá-los mesmo após destruídos. A maldição não é infinita — ela usa o que já existe, e cada esqueleto destruído é um esqueleto a menos para sempre.',
  'Você vê apenas ossos quebrados espalhados, alguns com armaduras velhas corroídas. Restos de combates anteriores.',
  true, 1
),
(
  gen_random_uuid(), v_s2_1_id,
  'Altar com runas (oliveira)', 'object', 'Arcana', 12,
  'As runas são símbolos de vinculação e memória — não de destruição ou maldição no sentido tradicional. Aldric não criou um feitiço de ataque; criou um feitiço de lembrança. O problema é que lembrança sem recipiente de consciência vira energia cega. A oliveira é a âncora física da maldição — destruí-la não resolve nada, porque a fonte real está embaixo.',
  'Você reconhece que são runas mágicas de algum tipo, mas não consegue identificar a escola ou o propósito. Parecem antigas.',
  true, 2
),
(
  gen_random_uuid(), v_s2_1_id,
  'Passagem secreta (entre as raízes)', 'hidden_passage', 'Investigation', 20,
  'Você encontra a tampa de pedra entre as raízes, perfeitamente encaixada no chão. Há marcas de mãos gravadas nos lados — como pegadas de quem esculpiu isso de dentro para fora. A tampa tem um trinco de pedra pelo lado de dentro; pelo lado de fora, abre com esforço físico (Atletismo DC 12).',
  'Você não encontra nada incomum nas raízes além do solo perturbado — que pode ter diversas explicações.',
  true, 3
);

-- Cena 2.2 — Os Corredores de Aldric
INSERT INTO scene_points_of_interest (id, scene_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order, npc_id)
VALUES
(
  gen_random_uuid(), v_s2_2_id,
  'Estátua de Aldric (mãos abertas)', 'object', 'History', 12,
  'A postura da figura — mãos abertas, palmas para cima — é reconhecível como gesto ritual de curandeiros pré-modernos, significando "ofereço o que tenho". Não é postura de poder ou ameaça. Quem reconhecer isso ganha vantagem no primeiro teste de interação com o Ghost de Aldric.',
  'Você vê uma estatueta tosca de pedra, provavelmente feita por mãos não treinadas em escultura. Parece uma pessoa com os braços estendidos.',
  true, 1, NULL
),
(
  gen_random_uuid(), v_s2_2_id,
  'Símbolo arcano no chão', 'ambience', NULL, NULL,
  'O círculo gravado no chão pulsa levemente com luz violeta se você olhar por mais de alguns segundos. Não é ameaçador — é mais como batimento cardíaco. É o feitiço respirando.',
  NULL, true, 2, NULL
),
(
  gen_random_uuid(), v_s2_2_id,
  'Ossos de Aldric com pergaminho', 'object', 'Investigation', 10,
  'Entre os ossos, você encontra um segundo pergaminho — dobrado dentro do que foi a caixa torácica. As palavras nele são as mesmas do pergaminho da casa, mas escritas de forma diferente: mais urgente, com letras pressionadas fundo no pergaminho. Esta versão parece ser o original, copiado depois para o diário. Usar este pergaminho no ritual tem o mesmo efeito que o da casa.',
  'Você vê os ossos cuidadosamente dispostos mas não encontra nada além deles e das pedras ao redor.',
  true, 3, NULL
);

-- Cena 2.3 — O Coração da Maldição
INSERT INTO scene_points_of_interest (id, scene_id, name, type, skill_check, dc, success_text, failure_text, enabled, sort_order)
VALUES
(
  gen_random_uuid(), v_s2_3_id,
  'Altar arcano central', 'object', 'Arcana', 15,
  'Você compreende o mecanismo completo: o altar é o ponto de transmissão do feitiço de memória de Aldric. Não é feitiço de necromância — é de conjuração de memória, escola muito rara. Para desfazê-lo, não é preciso destruir o altar: basta completar o ato que Aldric não pôde completar — ser reconhecido. O ritual exige palavras de reconhecimento ditas em voz alta por alguém que não seja Aldric.',
  'Você sente o poder no altar e entende que é o centro da maldição, mas não consegue discernir como funciona — só que interagir sem cuidado pode ter consequências.',
  true, 1
),
(
  gen_random_uuid(), v_s2_3_id,
  'Armadilha de pressão', 'trap', 'Investigation', 15,
  'Você nota a pedra levemente afundada antes de pisá-la. Pode contorná-la ou desativá-la removendo o mecanismo de pressão (Thieves'' Tools DC 12).',
  'Você não nota a pedra — o primeiro herói a passar por ela a ativa. Todos a 3 metros fazem Con DC 12 ou ficam cegos por 1 turno.',
  true, 2
),
(
  gen_random_uuid(), v_s2_3_id,
  'Fissura de fuga', 'hidden_passage', 'Perception', 20,
  'Você vê a fissura no canto sudeste e avalia que é larga o suficiente para uma pessoa de compleição média passar de lado. O túnel além sobe gradualmente — parece uma rota para a superfície, emergindo a uns cinquenta metros do cemitério.',
  'Você não nota a fissura sem procurar ativamente. Se procurar especificamente por saídas alternativas, o DC cai para 10.',
  true, 3
);

-- ============================================================
-- 8. DIALOGUE — Marta
-- ============================================================

INSERT INTO npc_dialogue_nodes (id, npc_id, node_key, text, is_root)
VALUES
(
  v_m_root, v_marta_id, 'root',
  'Chegaram tarde. Mas chegaram. Sente aí — em pé, vocês me cansam os olhos.',
  true
),
(
  v_m_a, v_marta_id, 'node_a',
  'Os mortos levantam. Toda noite, faz três semanas. Começou depois que enterramos o velho Harwick. Antes disso, nada. Só vida normal e chata como sempre foi.',
  false
),
(
  v_m_a1, v_marta_id, 'node_a1',
  'Harwick era o último. O último que lembrava de coisas que eu também lembro mas nunca disse.',
  false
),
(
  v_m_a1_ok, v_marta_id, 'node_a1_success',
  'Havia um curandeiro. Aldric. Morava perto do cemitério. Eu tinha oito anos quando ele foi embora. Nunca mais ninguém disse o nome dele em voz alta.',
  false
),
(
  v_m_a2, v_marta_id, 'node_a2',
  'O padre tenta. As rezas não chegam lá em cima. Não sei por quê — nunca vi bênção não chegar. Isso me diz que o problema é mais velho que as rezas dele.',
  false
),
(
  v_m_b, v_marta_id, 'node_b',
  'Tenho noventa e um anos. Meu medo ficou no caminho faz tempo. O que me resta é curiosidade — e vergonha de coisas que não dá mais pra consertar.',
  false
),
(
  v_m_b1, v_marta_id, 'node_b1',
  'De ficar calada quando não deveria. De oito anos sendo pouca idade para fazer a coisa certa. — pausa — Havia um homem que morava perto do portão do cemitério. Curandeiro. Bom homem. Foi embora num inverno muito frio e ninguém foi atrás.',
  false
),
(
  v_m_b2, v_marta_id, 'node_b2',
  'Coisas antigas. Anteriores a vocês. Vão lá pro padre — ele sabe o que começou quando começou, mesmo que não saiba o porquê.',
  false
),
(
  v_m_c, v_marta_id, 'node_c',
  'Eu não preciso de nada de vocês. Sento neste banco há sessenta anos. Sento amanhã também, com mortos ou sem.',
  false
),
(
  v_m_end, v_marta_id, 'node_end',
  'Olhem para a colina antes de anoitecer. O cemitério fica quieto de dia, mas o chão se mexe lá no fundo. Alguém que está lá dentro ainda quer ser lembrado. Não sei de mais nada.',
  false
);

INSERT INTO npc_dialogue_options (id, node_id, label, next_node_id, sort_order)
VALUES
-- root -> A, B, C
(gen_random_uuid(), v_m_root, 'O que está acontecendo nesta aldeia?',         v_m_a,      1),
(gen_random_uuid(), v_m_root, 'Você não parece assustada como os outros.',     v_m_b,      2),
(gen_random_uuid(), v_m_root, 'Precisamos de informações agora. Fale.',        v_m_c,      3),
-- node_a -> A1, A2
(gen_random_uuid(), v_m_a,    'Por que depois de Harwick especificamente?',    v_m_a1,     1),
(gen_random_uuid(), v_m_a,    'Alguém já tentou fazer algo a respeito?',       v_m_a2,     2),
-- node_a1 -> sucesso (requer Persuasion DC 13 — aplicado pelo sistema de condições)
(gen_random_uuid(), v_m_a1,   '[Persuasion DC 13] Mostre empatia sobre a injustiça.', v_m_a1_ok, 1),
(gen_random_uuid(), v_m_a1,   '[Falha] Insistir sem empatia.',                 v_m_end,    2),
-- node_a1_success -> end
(gen_random_uuid(), v_m_a1_ok,'Continuar conversa.',                           v_m_end,    1),
-- node_a2 -> end
(gen_random_uuid(), v_m_a2,   'Continuar conversa.',                           v_m_end,    1),
-- node_b -> B1, B2
(gen_random_uuid(), v_m_b,    'Vergonha de quê?',                              v_m_b1,     1),
(gen_random_uuid(), v_m_b,    'O que deveria ter sido consertado?',            v_m_b2,     2),
-- node_b1, b2 -> end
(gen_random_uuid(), v_m_b1,   'Continuar conversa.',                           v_m_end,    1),
(gen_random_uuid(), v_m_b2,   'Continuar conversa.',                           v_m_end,    1),
-- node_c -> end (requer pedido de desculpas DC 10 para reabrir, simplificado aqui)
(gen_random_uuid(), v_m_c,    '[Persuasion DC 10] Pedir desculpas.',           v_m_b,      1),
(gen_random_uuid(), v_m_c,    'Insistir na abordagem.',                        v_m_end,    2)
;

-- Condição para node_a1_success (requer Persuasion DC 13)
INSERT INTO npc_dialogue_conditions (id, option_id, condition_type, key, operator, value)
SELECT gen_random_uuid(), id, 'skill_check', 'Persuasion', '>=', '13'
FROM npc_dialogue_options
WHERE node_id = v_m_a1 AND label LIKE '%Persuasion DC 13%';

-- ============================================================
-- 9. DIALOGUE — Padre Henwick
-- ============================================================

INSERT INTO npc_dialogue_nodes (id, npc_id, node_key, text, is_root)
VALUES
(
  v_h_root, v_henwick_id, 'root',
  'Graças aos céus. São viajantes? Guerreiros? Precisamos de ajuda — não peço isso com facilidade. Não pedi em quarenta anos de ministério. Mas peço agora.',
  true
),
(
  v_h_a, v_henwick_id, 'node_a',
  'Há três semanas, toda noite, mortos levantam do cemitério ao norte. São nossos mortos — aldeões que conheço pelos nomes nas lápides. Eles descem até a praça, ficam um tempo, e voltam antes do amanhecer. Não atacam com intenção — mas matam por acidente, por força cega. Já perdemos dois.',
  false
),
(
  v_h_a1, v_henwick_id, 'node_a1',
  'Funcionam... até certo ponto. No raio da igreja, afasto os mais fracos. Mas a cinquenta metros do portão do cemitério, é como se a água sagrada evaporasse no ar. Nunca vi isso. Não tenho explicação teológica.',
  false
),
(
  v_h_a2, v_henwick_id, 'node_a2',
  'Na noite de três semanas atrás. O dia em que enterramos Harwick — o homem mais velho da aldeia. Tinha noventa e seis anos. Na noite seguinte ao enterro, os mortos levantaram pela primeira vez.',
  false
),
(
  v_h_b, v_henwick_id, 'node_b',
  'Precisamos que alguém vá ao cemitério — de dia, com calma — e descubra o que está causando isso. Tentei ir. Cheguei até o portão. Ouvi algo debaixo da terra que me fez voltar correndo. Não me orgulho disso, mas é a verdade.',
  false
),
(
  v_h_b1, v_henwick_id, 'node_b1',
  'Um som de alguém contando. Em voz muito baixa. Números, ou palavras em sequência. Não era assustador de início. Foi quando percebi que o som vinha de dentro da terra que corri.',
  false
),
(
  v_h_b2, v_henwick_id, 'node_b2',
  'Há uma oliveira velha no centro do cemitério — muito velha, anterior à aldeia. Os mais antigos diziam que ela estava lá antes de qualquer casa. Nas últimas semanas... ela está diferente. As folhas não caíram com o outono. No outono, Padre. Todas as outras árvores perderam as folhas. Ela não.',
  false
),
(
  v_h_c, v_henwick_id, 'node_c',
  'Talvez. Não sei. Mas meu fracasso ou não, as pessoas desta aldeia precisam de ajuda que eu não consigo dar. Podem ajudar ou não. Se não, peço que partam antes do anoitecer — não quero mais mortes.',
  false
),
(
  v_h_end, v_henwick_id, 'node_end',
  'A igreja está aberta. É o único lugar onde estão seguros depois do sol. Voltem aqui antes de anoitecer — com ou sem respostas. Não quero procurá-los amanhã entre as lápides.',
  false
);

INSERT INTO npc_dialogue_options (id, node_id, label, next_node_id, sort_order)
VALUES
-- root -> A, B, C
(gen_random_uuid(), v_h_root, 'O que exatamente está acontecendo aqui?',       v_h_a,   1),
(gen_random_uuid(), v_h_root, 'Como podemos ajudar?',                          v_h_b,   2),
(gen_random_uuid(), v_h_root, 'Isto é trabalho de magia negra. Seu fracasso é esperado.', v_h_c, 3),
-- node_a -> A1, A2
(gen_random_uuid(), v_h_a,    'Suas bênçãos não funcionam?',                   v_h_a1,  1),
(gen_random_uuid(), v_h_a,    'Quando exatamente começou?',                    v_h_a2,  2),
-- node_a1, a2 -> end
(gen_random_uuid(), v_h_a1,   'Continuar conversa.',                           v_h_end, 1),
(gen_random_uuid(), v_h_a2,   'Continuar conversa.',                           v_h_end, 1),
-- node_b -> B1, B2
(gen_random_uuid(), v_h_b,    'O que você ouviu?',                             v_h_b1,  1),
(gen_random_uuid(), v_h_b,    'Tem algo específico que devemos procurar lá?',  v_h_b2,  2),
-- node_b1, b2 -> end
(gen_random_uuid(), v_h_b1,   'Continuar conversa.',                           v_h_end, 1),
(gen_random_uuid(), v_h_b2,   'Continuar conversa.',                           v_h_end, 1),
-- node_c -> end
(gen_random_uuid(), v_h_c,    'Continuar conversa.',                           v_h_end, 1)
;

-- ============================================================
-- 10. DIALOGUE — Ghost de Aldric
-- ============================================================

INSERT INTO npc_dialogue_nodes (id, npc_id, node_key, text, is_root)
VALUES
(
  v_g_root, v_aldric_id, 'root',
  'Vocês sabem o nome dele?',
  true
),
(
  v_g_a, v_aldric_id, 'node_a',
  'Faz muito tempo que ninguém disse. — pausa — Vocês vieram da aldeia?',
  false
),
(
  v_g_a1, v_aldric_id, 'node_a1',
  'Eu sei. Não era para ser assim. Eu queria apenas... que alguém se lembrasse. O feitiço era para memória. Não para isto. — voz mais baixa — Eu não sabia que a dor podia fazer isso.',
  false
),
(
  v_g_a2, v_aldric_id, 'node_a2',
  'Quem contou? — sem esperar resposta — Não importa. Que alguém saiba... já é mais do que eu esperava encontrar aqui.',
  false
),
(
  v_g_b, v_aldric_id, 'node_b',
  'Fui exilado. Sim. — olha para as próprias mãos translúcidas — Mas antes fui curandeiro. Às vezes esqueço nessa ordem.',
  false
),
(
  v_g_b1, v_aldric_id, 'node_b1',
  'O diário ainda estava lá. — não é pergunta — Então vocês sabem da criança. Do inverno. De Harwick. — pausa — Vocês vieram terminar isso?',
  false
),
(
  v_g_b2, v_aldric_id, 'node_b2',
  'Então está na hora. Digam as palavras aqui, neste lugar, com intenção. Não como fórmula — como verdade.',
  false
),
(
  v_g_c, v_aldric_id, 'node_c',
  'Inocentes. — repete a palavra como se estivesse pesando — Eles enterraram um homem inocente no frio.',
  false
),
(
  v_g_ritual, v_aldric_id, 'node_ritual',
  'Obrigado. — a voz agora está completamente em sincronia — Cuide da oliveira. Arrancá-la vai quebrar o feitiço. Deixa ela onde está — ela vai morrer sozinha agora.',
  false
);

INSERT INTO npc_dialogue_options (id, node_id, label, next_node_id, sort_order)
VALUES
-- root -> A, B, C
(gen_random_uuid(), v_g_root, '"Aldric."',                                          v_g_a,      1),
(gen_random_uuid(), v_g_root, '"Você é Aldric. O curandeiro que foi exilado."',     v_g_b,      2),
(gen_random_uuid(), v_g_root, '"Você precisa parar. Está machucando pessoas inocentes."', v_g_c, 3),
-- node_a -> A1, A2
(gen_random_uuid(), v_g_a,    '"Sim. Eles estão com medo. Os mortos estão levantando."',      v_g_a1, 1),
(gen_random_uuid(), v_g_a,    '"Sabemos o que aconteceu com você. A expulsão, o inverno."',   v_g_a2, 2),
-- node_a1, a2 -> ritual
(gen_random_uuid(), v_g_a1,   '[Realizar ritual de apaziguamento]',                 v_g_ritual, 1),
(gen_random_uuid(), v_g_a2,   '[Realizar ritual de apaziguamento]',                 v_g_ritual, 1),
-- node_b -> B1, B2
(gen_random_uuid(), v_g_b,    '"Encontramos seu diário. Lemos sua história."',      v_g_b1,     1),
(gen_random_uuid(), v_g_b,    '"Encontramos o pergaminho com suas palavras."',      v_g_b2,     2),
-- node_b1, b2 -> ritual
(gen_random_uuid(), v_g_b1,   '[Realizar ritual de apaziguamento]',                 v_g_ritual, 1),
(gen_random_uuid(), v_g_b2,   '[Realizar ritual de apaziguamento]',                 v_g_ritual, 1),
-- node_c -> com empatia -> a1; sem empatia -> hostil (sem next_node = fim hostil)
(gen_random_uuid(), v_g_c,    '[Insight DC 10] "Você tem razão. O que fizeram foi injusto."', v_g_a1, 1),
(gen_random_uuid(), v_g_c,    'Insistir na acusação.',                              NULL,       2)
;

RAISE NOTICE 'Campaign ID: %', v_campaign_id;
RAISE NOTICE 'Adventure 1 ID: %', v_adv1_id;
RAISE NOTICE 'Adventure 2 ID: %', v_adv2_id;
RAISE NOTICE 'NPC Marta ID: %', v_marta_id;
RAISE NOTICE 'NPC Henwick ID: %', v_henwick_id;
RAISE NOTICE 'NPC Aldric Ghost ID: %', v_aldric_id;

END $$;
