# Ante-câmara do Selo

- adventure_index: 2
- scene_index: 3
- slug: ante-camara-do-selo
- location_id: dungeon
- description: |
  Uma pequena sala circular que precede o Salão do Trono. O ar aqui é gelado e o som de correntes batendo ecoa pelas paredes.

## Pontos de Interesse

- nome: Baú de Suprimentos
  tipo: treasure
  dc: 15
  skill: investigation
  success_text: Você encontra um compartimento secreto com água benta e pergaminhos de proteção.
  failure_text: O baú parece conter apenas panos velhos e ferramentas enferrujadas.

- nome: Porta dos Fundos
  tipo: hidden_passage
  dc: 18
  skill: perception
  success_text: Você localiza uma pequena fresta na tapeçaria que leva a uma posição vantajosa no Salão do Trono.
  failure_text: Você não encontra outra saída além da porta principal pesada.

## Criaturas

- creature_id: mimic
  creature_name: Baú Mimético
  quantity: 1
  behavior_note: Disfarçado como o baú de suprimentos, ataca quem tentar abri-lo sem cuidado.
  xp_value: 450
  cr: 2

- creature_id: wraith
  creature_name: Carrasco Espectral
  quantity: 1
  behavior_note: Patrulha a ante-câmara incansavelmente.
  xp_value: 1800
  cr: 5

## Validação SRD

- xp_total_encontro: 2250
- orcamento_low: 2000
- orcamento_moderate: 3000
- orcamento_high: 4400
- classificacao: moderate
- aviso: null
