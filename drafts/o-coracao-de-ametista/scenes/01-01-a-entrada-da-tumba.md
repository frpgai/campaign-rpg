# A Entrada da Tumba

- adventure_index: 1
- scene_index: 1
- slug: a-entrada-da-tumba
- location_id: forest
- description: |
  A vegetação aqui é densa e retorcida. Entre duas árvores ancestrais, uma escadaria de pedra desce para a escuridão. O cheiro de terra úmida e decomposição é forte.

## Pontos de Interesse

- nome: Armadilha de Flechas
  tipo: trap
  dc: 15
  skill: perception
  success_text: Você percebe uma placa de pressão camuflada entre as raízes e consegue evitá-la.
  failure_text: Você pisa em uma placa de pressão e ouve o disparo de flechas vindas das árvores!

## Criaturas

- creature_id: wolf
  creature_name: Wolf
  quantity: 2
  behavior_note: Atacam em bando, tentando derrubar o alvo mais próximo.
  xp_value: 50
  cr: 1/4

- creature_id: brown-bear
  creature_name: Brown Bear
  quantity: 1
  behavior_note: Protege a entrada da tumba, atacando ferozmente quem se aproximar.
  xp_value: 200
  cr: 1

## Validação SRD

- xp_total_encontro: 300
- orcamento_low: 600
- orcamento_moderate: 900
- orcamento_high: 1600
- classificacao: low
- aviso: null
