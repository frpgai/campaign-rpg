# O Bosque das Aranhas

- adventure_index: 1
- scene_index: 2
- slug: o-bosque-das-aranhas
- location_id: forest
- description: |
  As árvores aqui estão cobertas por teias densas e brilhantes. A energia do vórtice está acelerando o crescimento das criaturas locais.

## Pontos de Interesse

- nome: Fissura na Parede
  tipo: hidden_passage
  dc: 20
  skill: perception
  success_text: Atrás de uma cortina de teias, você encontra uma fenda na rocha que parece levar a um atalho.
  failure_text: Você não encontra nada além de teias pegajosas.

- nome: Baú Trancado
  tipo: treasure
  dc: 15
  skill: investigation
  success_text: Você encontra um baú antigo enredado em teias. Dentro há suprimentos e algumas moedas. [SRD 5.2.1 — CC-BY-4.0]
  failure_text: O baú está muito bem escondido ou você não consegue abri-lo sem atrair atenção.

## Criaturas

- quantity_mode: per_player

- creature_id: null
  creature_name: Giant Spider
  quantity: 0.5
  behavior_note: As aranhas atacam do teto de copas das árvores.
  xp_value: 200
  cr: 1

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro: 100
- orcamento_low: 150
- orcamento_moderate: 225
- orcamento_high: 400
- classificacao: low
- aviso: null

## Navegação [OBRIGATÓRIO]
- [Cena Anterior](./01-01-o-limiar-da-floresta.md)
- [Próxima Cena](./01-03-a-entrada-do-templo.md)
