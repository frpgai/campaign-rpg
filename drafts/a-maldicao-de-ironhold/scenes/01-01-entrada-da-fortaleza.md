# Entrada da Fortaleza

- adventure_index: 1
- scene_index: 1
- slug: entrada-da-fortaleza
- location_id: dungeon
- description: |
  Os portões de ferro de Ironhold estão entreabertos, rangendo ao vento frio. Corpos de antigos guardas jazem no chão, mas suas armaduras parecem se mover sozinhas.

## Pontos de Interesse

- nome: Grade do Portão
  tipo: object
  dc: 15
  skill: athletics
  success_text: Você consegue erguer a grade emperrada o suficiente para o grupo passar sem fazer barulho.
  failure_text: A grade cai com um estrondo metálico, alertando qualquer coisa nas proximidades.

- nome: Ossos no Chão
  tipo: object
  dc: 10
  skill: investigation
  success_text: Você percebe que os ossos foram limpos cirurgicamente, indicando a presença de algo que consome carne rapidamente.
  failure_text: Parecem apenas restos de uma batalha antiga, nada fora do comum.

## Criaturas

- creature_id: skeleton
  creature_name: Esqueleto de Guarda
  quantity: 8
  behavior_note: Atacam qualquer um que tente cruzar o portal.
  xp_value: 50
  cr: 1/4

## Validação SRD

- xp_total_encontro: 400
- orcamento_low: 2000
- orcamento_moderate: 3000
- orcamento_high: 4400
- classificacao: low
- aviso: null
