# O Salão dos Lamentos

- adventure_index: 2
- scene_index: 1
- slug: o-salao-dos-lamentos
- location_id: dungeon
- description: |
  O ar é gelado e cheira a mofo. O chão está repleto de ossos de aventureiros que falharam em sua missão. Sombras parecem se mover nos cantos da visão.

## Pontos de Interesse

- nome: Ossos no Chão
  tipo: object
  dc: 10
  skill: investigation
  success_text: "Você percebe que os ossos estão organizados de forma não natural, indicando um despertar iminente."
  failure_text: "Apenas ossos velhos e quebradiços."

- nome: Armadilha de Pressão
  tipo: trap
  dc: 15
  skill: investigation
  success_text: "Você nota uma placa de pressão sob uma camada de poeira."
  failure_text: "Um click metálico ecoa quando você pisa no centro do salão."

## Criaturas

- creature_id: null
  creature_name: Skeleton
  quantity: 8
  behavior_note: "Eles se levantam dos montes de ossos assim que o grupo chega ao centro da sala."
  xp_value: 50
  cr: "1/4"

## Validação SRD

- xp_total_encontro: 400
- orcamento_low: 600
- orcamento_moderate: 900
- orcamento_high: 1600
- classificacao: low
- aviso: null
