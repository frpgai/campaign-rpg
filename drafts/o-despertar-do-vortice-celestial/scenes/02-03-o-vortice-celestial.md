# O Vórtice Celestial

- adventure_index: 2
- scene_index: 3
- slug: o-vortice-celestial
- location_id: temple
- description: |
  A fenda celestial rasga o teto do templo. Uma entidade de pura fúria espectral emerge para impedir o fechamento do portal.

## Pontos de Interesse

- nome: Foco do Vórtice
  tipo: object
  dc: 15
  skill: arcana
  success_text: Você consegue canalizar sua energia para estabilizar a fenda momentaneamente, facilitando o combate.
  failure_text: A energia te repele, causando cansaço mental.

- nome: Símbolo Arcano
  tipo: ambience
  dc: null
  skill: null
  success_text: O centro do vórtice é o ponto onde o grupo deve concentrar suas ações para selar a fenda.
  failure_text: null

## Criaturas

- creature_id: null
  creature_name: Wraith
  quantity: 1
  quantity_mode: per_player
  behavior_note: |
    O Wraith drena a vitalidade de quem se aproxima do portal.
    ESCALA DE BOSS: HP: 67 * num_players | XP: 450 * num_players.
  xp_value: 450
  cr: 5

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro_por_pc: 450
- orcamento_low_por_pc: 150
- orcamento_moderate_por_pc: 225
- orcamento_high_por_pc: 400
- classificacao: high
- aviso: |
    AVISO SRD — Encontro muito difícil [SRD 5.2.1 linhas 39411-39680 — CC-BY-4.0]
    XP base (por PC): 450 XP
    Orçamento High (por PC) para nível 3: 400 XP
    Este encontro excede o orçamento High em 12.5%.
    Uma criatura com CR 5 pode eliminar um personagem de nível 3 com uma única ação.

## Navegação [OBRIGATÓRIO]
- [Voltar para Aventura Pai](../adventures/02-o-templo-do-vortice.md)
- [Ver Mapa de Cenas](../scene-tree.md)
- [Voltar para a Campanha](../campaign.md)
