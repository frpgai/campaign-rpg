# Pátio dos Espectros

- adventure_index: 1
- scene_index: 2
- slug: patio-dos-espectros
- location_id: dungeon
- description: |
  O pátio interno é dominado por uma névoa densa que brilha com uma luz azulada pálida. Vultos translúcidos vagam sem rumo.

## Pontos de Interesse

- nome: Estátua do Fundador
  tipo: object
  dc: 12
  skill: history
  success_text: Você reconhece a estátua do Duque Ironhold I e nota um compartimento escondido na base.
  failure_text: É uma estátua desgastada pelo tempo e pela névoa, sem detalhes discerníveis.

- nome: Baú Trancado
  tipo: treasure
  dc: 15
  skill: investigation
  success_text: Você encontra o mecanismo e abre o baú, revelando poções de cura e prata.
  failure_text: Você não consegue abrir a tranca e quase aciona uma pequena armadilha de agulha.

## Criaturas

- creature_id: ghost
  creature_name: Espectro Torturado
  quantity: 2
  behavior_note: Tentam possuir os invasores para expulsá-los do pátio.
  xp_value: 1100
  cr: 4

## Validação SRD

- xp_total_encontro: 2200
- orcamento_low: 2000
- orcamento_moderate: 3000
- orcamento_high: 4400
- classificacao: moderate
- aviso: null
