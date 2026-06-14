# O Limiar da Floresta

- adventure_index: 1
- scene_index: 1
- slug: o-limiar-da-floresta
- location_id: forest
- description: |
  A entrada da floresta é marcada por árvores retorcidas e uma névoa baixa. O ar cheira a ozônio e madeira queimada.

## Pontos de Interesse

- nome: Fogueira Apagada
  tipo: ambience
  dc: null
  skill: null
  success_text: As cinzas ainda estão quentes, mas não há sinais de quem as deixou.
  failure_text: null

- nome: Armadilha de Flechas
  tipo: trap
  dc: 15
  skill: perception
  success_text: Você percebe uma linha quase invisível esticada entre duas árvores. [SRD 5.2.1 — CC-BY-4.0]
  failure_text: Você dispara a armadilha e uma rajada de flechas é disparada da folhagem!

## Criaturas

- quantity_mode: per_player

- creature_id: null
  creature_name: Wolf
  quantity: 1
  behavior_note: Os lobos parecem frenéticos e seus olhos brilham com uma luz azulada.
  xp_value: 50
  cr: 1/4

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro: 50
- orcamento_low: 150
- orcamento_moderate: 225
- orcamento_high: 400
- classificacao: low
- aviso: null

## Navegação [OBRIGATÓRIO]
- [Voltar para Aventura](../adventures/01-a-floresta-sussurrante.md)
- [Próxima Cena](./01-02-o-bosque-das-aranhas.md)
