# Cena 2.2 — O Ritual

- adventure_order: 2
- scene_order: 2
- narrative_function: Clímax narrativo e moral. Os heróis chegam durante o ritual — Serafina está em processo de despertar, o que permite uma janela de confronto antes que ela atinja poder total. A decisão moral central: destruir Serafina significa destruir também a consciência da nobre inocente que foi injustamente executada — ela é vítima tanto quanto ameaça. A mecânica de combate serve à narrativa, não o contrário.
- location_slug: temple
- description: |
  A câmara da Condessa é uma catedral subterrânea mais antiga que tudo acima dela — abóbodas de pedra negra sustentadas por pilares com faces esculpidas de mulheres chorando. No centro, um sarcófago de vidro negro no qual Serafina Vael jaz com olhos entreabertos, o corpo envolto em névoa luminescente. Em volta do sarcófago, doze cultistas de joelhos entoam em latim. A Madre Serafella — uma mulher idosa com voz firme — lidera o cântico de pé, segurando a Chave III. Nas paredes, os sigilos do ritual pulsam. Se os três sigilos forem alimentados pelas três chaves simultaneamente ao quinto sino, Serafina desperta com poder total. O quinto sino ainda não tocou. Há tempo — pouco, mas há.

## Pontos de Interesse

- poi_slug: arcane-altar
  name: Altar Central — O Sarcófago de Vidro Negro
  type: object
  skill: Arcana
  dc: 12
  flavor_text: "O sarcófago irradia frio mesmo a metros de distância. A mulher dentro — Serafina — tem uma expressão que não é de monstro: é de alguém que sofreu. Lágrimas congeladas nos cantos dos olhos. Um personagem que olha longa o suficiente ouvirá, apenas uma vez, uma voz na mente: 'Eu não pedi por isso.'"
  success_text: "O sarcófago é ao mesmo tempo prisão e fonte de poder — Serafina não controla completamente o que está se tornando. Destruir os três sigilos nas paredes antes do quinto sino interrompe o ritual e mantém o selo ativo, prendendo-a novamente. Ela não morre — mas não desperta. É a opção de 'selamento'. A outra opção: usar as três chaves nos sigilos em sequência inversa desfaz a fusão — libera a entidade e destrói o corpo de Serafina de vez (ela morre, finalmente em paz, mas a entidade precisa ser contida de outra forma)."
  failure_text: "O sarcófago parece simplesmente um artefato ritual. A mecânica do selo não é aparente sem estudo."

- poi_slug: statue
  name: Estátua — Serafina Vael, Antes
  type: object
  skill: History
  dc: 12
  flavor_text: "No canto da câmara, uma estátua de mármore branco — incongruente com o resto da câmara de pedra negra. Representa uma mulher jovem em vestes nobres, com expressão serena. A placa na base foi parcialmente destruída mas ainda legível: 'Serafina Vael — Condessa de Valdenmoor — Executada injustamente no ano 847. Que a verdade a liberte.'"
  success_text: "Alguém plantou esta estátua aqui deliberadamente — não foi a Seita. O monge Taddeus, provavelmente. Ela serve como âncora moral: a criatura no sarcófago era uma pessoa real, inocente, traída pelo sistema que deveria protegê-la. Destruí-la significa descanso eterno. Selá-la significa continuidade do sofrimento. O Mestre deve apresentar ambas as opções como igualmente válidas — não há resposta 'correta'."
  failure_text: "Estátua de uma nobre. Relevante para a história da cidade, talvez, mas não para a situação imediata."

- poi_slug: arcane-symbol
  name: Sigilos do Ritual — Três Pontos nas Paredes
  type: ambience
  skill: null
  dc: null
  flavor_text: "Três sigilos nas paredes — norte, leste e oeste — pulsam em sincronia com a respiração de Serafina no sarcófago. Cada um tem uma cavidade na forma de uma das três chaves. Os sigilos estão a 1/3 do brilho máximo. Quando o quinto sino tocar, eles atingirão brilho total e a câmara se fechará hermeticamente."
  success_text: null
  failure_text: null

- poi_slug: informant-npc
  name: Madre Serafella — Líder da Seita
  type: npc
  skill: null
  dc: null
  flavor_text: "Serafella para de cantar quando os heróis entram. Não grita. Não chama por reforços. Vira-se devagar. 'Vocês não entendem o que estão impedindo. Ela sofreu. Ela merece despertar.' Há genuína convicção em sua voz — ela não é uma vilã de capa e espada. Acredita que está libertando Serafina. 'Destruam os sigilos se quiserem. Mas saibam: selar ela de volta é condená-la a outros quarenta anos de agonia.'"
  success_text: null
  failure_text: null

- poi_slug: false-wall
  name: Parede Falsa — Saída de Emergência
  type: hidden_passage
  skill: Investigation
  dc: 20
  flavor_text: "A câmara parece não ter saída além de onde os heróis entraram. Mas a câmara foi construída com uma saída — para os construtores originais, não para a Seita."
  success_text: "Um corredor estreito leva para cima, saindo em uma sacristia abandonada da catedral. Se o ritual for interrompido, esta é a rota de fuga antes que a câmara colapse parcialmente (o colapso é parcial — nenhum personagem precisa morrer, mas a urgência é real)."
  failure_text: "A câmara é uma câmara. Não há outra saída visível."

## Criaturas

AVISO DE BOSS [SRD 5.2.1 — CC-BY-4.0]:
Serafina Vael como Vampire Spawn (CR 5, 1800 XP base) está dramaticamente acima do budget para grupo nível 1
(High budget: 400 XP total para 4 jogadores). Usar Vampire Spawn como boss narrativo requer ajuste de Mestre.

Duas opções documentadas abaixo — Mestre escolhe conforme intenção narrativa:

OPÇÃO A — Boss Narrativo (Serafina em processo de despertar, poder reduzido):
Use as estatísticas de proxy abaixo. Serafina não está com poder total — o ritual está incompleto.
Fluff: ela luta do interior do sarcófago com projeções e influência mental, não corpo a corpo direto.

- creature_name: Cultist
  quantity: 2
  quantity_mode: per_player
  behavior_note: |
    Cultistas que protegem o ritual enquanto Serafina não está totalmente desperta. Fanáticos — não recuam. Se a Madre Serafella for incapacitada, os cultistas ficam desorientados por 1 turno (sem ação) antes de retomar. XP Recompensa deve ser distribuído apenas se o grupo confrontar em combate — a opção de negociação com Serafella não gera XP de combate mas avança o ritual da decisão moral.
  xp_value: 25
  cr: "1/8"

- creature_name: Skeleton
  quantity: 1
  quantity_mode: per_player
  behavior_note: |
    Guardiões animados por Serafina dentro da câmara. Mais rápidos que os do corredor — a proximidade da Condessa os fortalece (narrativo, sem alteração mecânica). Se os sigilos forem destruídos, os esqueletos desabam imediatamente — sua animação vem do ritual.
  xp_value: 50
  cr: "1/4"

OPÇÃO B — Boss Real (Serafina desperta parcialmente durante a luta):
- creature_name: Vampire Spawn
  quantity: 1
  quantity_mode: per_player
  behavior_note: |
    BOSS NARRATIVO — Serafina Vael, a Condessa Sepultada. Use como boss único com HP e XP escalados.
    HP: 82 * num_players (ou reduza para 40 * num_players para nível 1).
    XP: 1800 * num_players.
    AVISO: CR 5 vs Grupo Nível 1 é encontro potencialmente letal. Mestre deve considerar reduzir HP drasticamente
    (ex: 20 HP fixo independente de jogadores) e remover ataques de mordida para tornar o encontro narrativamente
    tenso sem ser impossível. A cena é projetada para resolução por decisão moral, não necessariamente por combate.
    [SRD 5.2.1 — CC-BY-4.0]
  xp_value: 1800
  cr: "5"

RECOMENDAÇÃO: Use a Opção A para manter o encontro jogável em nível 1 e focar na decisão moral.
Reserve a Opção B para grupos experientes que queiram o risco real.

## Transição Narrativa

Independente da escolha — selamento ou liberação — o quinto sino toca ao longe enquanto as consequências se desenrolam. Se selamento: os sigilos pulsam e o sarcófago se fecha definitivamente, com Serafina dentro, olhos fechados. Se liberação: uma luz explode do sarcófago, o corpo de Serafina se dissolve com expressão de alívio, e algo escurece o ar por um momento antes de se dissipar (a entidade liberada mas sem âncora vai embora). A câmara começa a tremeluzir. A saída pela parede falsa (se encontrada) é o caminho. Se não encontrada, a saída original ainda funciona — mas o colapso parcial fecha o acesso permanentemente aos subterrâneos. Valdenmoor acorda ao amanhecer. Com moradores vivos.

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

OPÇÃO A (recomendada para nível 1):
- xp_total_encontro_por_pc: 100
  - Cultist x2: 25 XP x 2 = 50 XP/PC
  - Skeleton x1: 50 XP x 1 = 50 XP/PC
  - Total: 100 XP/PC
- orcamento_low_por_pc: 50
- orcamento_moderate_por_pc: 75
- orcamento_high_por_pc: 100
- classificacao: high (100 XP/PC = exatamente o teto High)
- aviso: null — encontro no limite do budget High. Apropriado para clímax.

OPÇÃO B (boss real):
- xp_total_encontro_por_pc: 1800
- classificacao: fora de escala (1800 XP/PC vs. High = 100 XP/PC — 18x acima do budget)
- aviso: "AVISO CRÍTICO — Vampire Spawn CR 5 representa encontro potencialmente letal para grupo nível 1. Usar apenas com ajuste drástico de HP e expectativa narrativa clara com o grupo. [SRD 5.2.1 — CC-BY-4.0]"

## Navegação [OBRIGATÓRIO]

- [Voltar para o Ato 2](../adventures/02-a-camara-da-condessa.md)
- [Cena Anterior — 2.1: A Descida](./02-01-a-descida.md)
- [Fim da Campanha — Ver Revisão Completa](../REVIEW.md)
- [A História Completa](../story.md)
