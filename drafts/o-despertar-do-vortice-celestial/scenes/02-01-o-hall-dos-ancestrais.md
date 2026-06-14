# O Hall dos Ancestrais

- adventure_index: 2
- scene_index: 1
- slug: o-hall-dos-ancestrais
- location_id: temple
- description: |
  O corredor principal do templo é ladeado por tumbas abertas. Os mortos foram erguidos pela energia desenfreada do vórtice.

## Pontos de Interesse

- nome: Baú Trancado
  tipo: treasure
  dc: 15
  skill: investigation
  success_text: Você encontra um baú que contém pergaminhos de proteção celestial. [SRD 5.2.1 — CC-BY-4.0]
  failure_text: O baú está lacrado com magia ou simplesmente emperrado.

- nome: Parede Falsa
  tipo: hidden_passage
  dc: 20
  skill: investigation
  success_text: Você percebe uma irregularidade nos entalhes da parede e descobre um nicho com relíquias. [SRD 5.2.1 — CC-BY-4.0]
  failure_text: A parede parece sólida e imutável.

## Criaturas

- quantity_mode: per_player

- creature_id: null
  creature_name: Skeleton
  quantity: 1
  behavior_note: Esqueletos que parecem estar tentando empurrar os invasores para fora do templo.
  xp_value: 50
  cr: 1/4

- creature_id: null
  creature_name: Zombie
  quantity: 0.5
  behavior_note: Mortos-vivos lentos que bloqueiam o caminho principal.
  xp_value: 50
  cr: 1/4

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro: 75
- orcamento_low: 150
- orcamento_moderate: 225
- orcamento_high: 400
- classificacao: low
- aviso: null

## Navegação [OBRIGATÓRIO]
- [Voltar para Aventura](../adventures/02-o-templo-do-vortice.md)
- [Próxima Cena](./02-02-o-altar-arcano.md)
