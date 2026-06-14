# O Salão dos Lamentos

- adventure_index: 1
- scene_index: 2
- slug: o-salao-dos-lamentos
- location_id: dungeon
- description: |
  Um corredor longo e frio, decorado com estátuas de guardiões chorosos. O som de correntes arrastando ecoa pelas paredes de pedra.

## Pontos de Interesse

- nome: Ossos no Chão
  tipo: object
  dc: 10
  skill: investigation
  success_text: Você percebe que os ossos foram limpos por dentes pequenos, sugerindo a presença de algo mais do que apenas mortos-vivos.
  failure_text: Você apenas vê uma pilha de ossos velhos e quebradiços.

- nome: Baú Trancado
  tipo: treasure
  dc: 15
  skill: investigation
  success_text: Você consegue abrir o baú e encontra 50 peças de ouro e uma poção de cura.
  failure_text: O mecanismo está emperrado e você não consegue abrir o baú.

## Criaturas

- creature_id: skeleton
  creature_name: Skeleton
  quantity: 4
  behavior_note: Emergem das sombras e atacam com espadas curtas enferrujadas.
  xp_value: 50
  cr: 1/4

## Validação SRD

- xp_total_encontro: 200
- orcamento_low: 600
- orcamento_moderate: 900
- orcamento_high: 1600
- classificacao: low
- aviso: null
