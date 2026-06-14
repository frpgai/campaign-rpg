# O Portal de Pedra

- adventure_index: 1
- scene_index: 3
- slug: o-portal-de-pedra
- location_id: forest
- description: |
  Um grande portal de pedra natural marca a transição para a entrada da dungeon. Uma fera terrível guarda este local, atraída pela energia sombria que emana da terra.

## Pontos de Interesse

- nome: Fissura na Parede
  tipo: hidden_passage
  dc: 20
  skill: perception
  success_text: "Você encontra uma pequena fresta que permite observar o interior da dungeon."
  failure_text: "Parece apenas uma rocha comum."

- nome: Armadilha de Flechas
  tipo: trap
  dc: 15
  skill: perception
  success_text: "Você percebe os orifícios nas árvores laterais."
  failure_text: "Flechas disparam ao pisar em uma corda esticada."

## Criaturas

- creature_id: null
  creature_name: Owlbear
  quantity: 1
  behavior_note: "Muito territorial, ataca qualquer coisa que se aproxime do portal."
  xp_value: 700
  cr: "3"

## Validação SRD

- xp_total_encontro: 700
- orcamento_low: 600
- orcamento_moderate: 900
- orcamento_high: 1600
- classificacao: moderate
- aviso: null
