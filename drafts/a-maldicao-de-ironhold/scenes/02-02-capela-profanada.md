# Capela Profanada

- adventure_index: 2
- scene_index: 2
- slug: capela-profanada
- location_id: temple
- description: |
  O local sagrado de Ironhold foi distorcido por energias negras. O altar está rachado e emana uma fumaça fétida.

## Pontos de Interesse

- nome: Altar Arcano
  tipo: object
  dc: 15
  skill: arcana
  success_text: Você executa o ritual de purificação, enfraquecendo o selo que prende o Duque.
  failure_text: O ritual falha, causando uma explosão de energia necrótica que atinge a todos.

- nome: Estátua da Divindade
  tipo: object
  dc: 12
  skill: religion
  success_text: Você encontra um símbolo sagrado escondido que pode ser usado contra os mortos-vivos.
  failure_text: Você não sente nenhuma presença divina no local, apenas o vazio.

## Criaturas

- creature_id: ghost
  creature_name: Sacerdote Maldito
  quantity: 1
  behavior_note: O fantasma do sacerdote tenta impedir qualquer tentativa de purificação do altar.
  xp_value: 1100
  cr: 4

- creature_id: zombie
  creature_name: Acólitos Reanimados
  quantity: 4
  behavior_note: Protegem o sacerdote e o altar.
  xp_value: 50
  cr: 1/4

## Validação SRD

- xp_total_encontro: 1300
- orcamento_low: 2000
- orcamento_moderate: 3000
- orcamento_high: 4400
- classificacao: low
- aviso: null
