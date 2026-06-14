# Biblioteca Arcana

- adventure_index: 1
- scene_index: 4
- slug: biblioteca-arcana
- location_id: temple
- description: |
  Livros flutuam no ar e as prateleiras parecem sussurrar segredos esquecidos. No centro, uma mesa de pedra contém um pergaminho que brilha intensamente.

## Pontos de Interesse

- nome: Pergaminho do Selo
  tipo: object
  dc: 15
  skill: arcana
  success_text: Você decifra o pergaminho e descobre que o selo só pode ser quebrado por uma prece na Capela Profanada.
  failure_text: As runas mudam de forma diante dos seus olhos, causando uma forte dor de cabeça e confusão.

- nome: Símbolo Arcano
  tipo: ambience
  dc: null
  skill: null
  success_text: null
  failure_text: null

## Criaturas

- creature_id: wraith
  creature_name: Guardião da Biblioteca
  quantity: 1
  behavior_note: O Wraith protege o pergaminho com fúria, drenando a vida dos que se aproximam.
  xp_value: 1800
  cr: 5

## Validação SRD

- xp_total_encontro: 1800
- orcamento_low: 2000
- orcamento_moderate: 3000
- orcamento_high: 4400
- classificacao: low
- aviso: null
