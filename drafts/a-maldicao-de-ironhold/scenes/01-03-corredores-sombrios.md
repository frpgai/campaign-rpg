# Corredores Sombrios

- adventure_index: 1
- scene_index: 3
- slug: corredores-sombrios
- location_id: dungeon
- description: |
  Estreitos e opressores, estes corredores levam às áreas administrativas e à biblioteca. Tochas de fogo fátuo iluminam as paredes de pedra úmida.

## Pontos de Interesse

- nome: Armadilha de Pressão
  tipo: trap
  dc: 15
  skill: investigation
  success_text: Você avista a placa levemente elevada e avisa o grupo para contorná-la.
  failure_text: Você pisa na placa, disparando dardos envenenados das paredes.

- nome: Parede Falsa
  tipo: hidden_passage
  dc: 20
  skill: investigation
  success_text: Você encontra um tijolo solto que abre uma passagem secreta para a Biblioteca, evitando guardas.
  failure_text: A parede parece sólida e sem segredos.

## Criaturas

- creature_id: zombie
  creature_name: Zumbi Reanimado
  quantity: 6
  behavior_note: Emergem das sombras e atacam em horda.
  xp_value: 50
  cr: 1/4

## Validação SRD

- xp_total_encontro: 300
- orcamento_low: 2000
- orcamento_moderate: 3000
- orcamento_high: 4400
- classificacao: low
- aviso: null
