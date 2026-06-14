# O Altar Arcano

- adventure_index: 2
- scene_index: 2
- slug: o-altar-arcano
- location_id: temple
- description: |
  Uma câmara circular onde um altar de obsidiana flutua sob a influência da fenda celestial. Um espírito protetor vigia o local.

## Pontos de Interesse

- nome: Altar Arcano
  tipo: object
  dc: 12
  skill: arcana
  success_text: Você entende o fluxo da energia e descobre que o altar serve como um estabilizador para o vórtice. [SRD 5.2.1 — CC-BY-4.0]
  failure_text: A energia é confusa e violenta demais para ser compreendida.

- nome: Espírito Agonizante
  tipo: npc
  dc: 10
  skill: persuasion
  success_text: "O espírito sussurra: 'O sacrifício de luz deve ser feito para fechar o portal.'"
  failure_text: "O espírito desvanece em um lamento sem dizer nada útil."

## Criaturas

- creature_id: null
  creature_name: Ghost
  quantity: 0.25
  quantity_mode: per_player
  behavior_note: O espírito de um antigo sumo-sacerdote que confunde o grupo com profanadores.
  xp_value: 1100
  cr: 4

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro_base: 275
- orcamento_low_por_pc: 150
- orcamento_moderate_por_pc: 225
- orcamento_high_por_pc: 400
- classificacao: moderate
- aviso: null

## Navegação [OBRIGATÓRIO]
- [Voltar para Aventura Pai](../adventures/02-o-templo-do-vortice.md)
- [Ver Mapa de Cenas](../scene-tree.md)
- [Próxima Cena: O Vórtice Celestial](./02-03-o-vortice-celestial.md)
