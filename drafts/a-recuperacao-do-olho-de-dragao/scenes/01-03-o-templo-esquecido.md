# O Templo Esquecido

- adventure_index: 1
- scene_index: 3
- slug: o-templo-esquecido
- location_id: temple
- description: |
  As portas de pedra do templo se abrem para um salão vasto e frio. No centro, um altar emana uma luz carmesim pulsante. O ritual de ativação do Olho de Dragão está em seu clímax.

## Pontos de Interesse

- nome: Altar Arcano de Sangue
  tipo: object
  dc: 15
  skill: arcana
  success_text: "Você identifica o ponto fraco do fluxo de energia. Se o altar for perturbado, o Olho de Dragão ficará vulnerável e o ritual será interrompido."
  failure_text: "A energia é caótica demais para ser compreendida, e apenas olhar para o altar causa náuseas."

- nome: Estátua do Dragão de Pedra
  tipo: object
  dc: 12
  skill: history
  success_text: "A estátua representa Vhalrax, o Destruidor. Diz a lenda que seu olho esquerdo foi arrancado para criar a joia que o culto agora detém."
  failure_text: "Uma estátua antiga e imponente, mas seus detalhes estão gastos pelo tempo."

## Criaturas

- creature_id: null
  creature_name: Wraith
  quantity: 1
  behavior_note: "O guardião espectral do templo, convocado pelo sacrifício do culto."
  xp_value: 1800
  cr: "5"

- creature_id: null
  creature_name: Cultist
  quantity: 4
  behavior_note: "Focam em manter o ritual enquanto o Wraith ataca os intrusos."
  xp_value: 25
  cr: "1/8"

## Validação SRD

- xp_total_encontro: 1900
- orcamento_low: 1000
- orcamento_moderate: 1500
- orcamento_high: 2000
- classificacao: high
- aviso: "Nota: Uma criatura de CR 5 (Wraith) contra um grupo de Nível 4 representa um desafio significativo."

## Navegação [OBRIGATÓRIO]
- [Voltar para Aventura Pai](../adventures/01-a-cacada-ao-culto.md)
- [Ver Mapa de Cenas](../scene-tree.md)
- [Voltar para a Campanha](../campaign.md)
