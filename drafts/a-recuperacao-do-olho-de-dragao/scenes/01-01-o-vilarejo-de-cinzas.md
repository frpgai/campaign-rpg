# O Vilarejo de Cinzas

- adventure_index: 1
- scene_index: 1
- slug: o-vilarejo-de-cinzas
- location_id: village
- description: |
  O que restou da Vila de Cinzas após o ataque do culto. Fumaça ainda sobe das casas destruídas e o silêncio é interrompido apenas pelo estalar das brasas.

## Pontos de Interesse

- nome: O Sobrevivente Encurralado
  tipo: npc
  dc: 12
  skill: persuasion
  success_text: "O sobrevivente revela que os cultistas usavam mantos vermelhos e fugiram para o norte, em direção à Floresta Sussurrante."
  failure_text: "O sobrevivente está em choque profundo e apenas aponta para o norte, tremendo de medo."

- nome: Restos da Fogueira do Acampamento
  tipo: ambience
  dc: 10
  skill: investigation
  success_text: "Entre as cinzas, você encontra um retalho de tecido de seda vermelha com o símbolo de um olho envolto em chamas."
  failure_text: "Você encontra apenas cinzas comuns e restos de madeira."

## Criaturas

- creature_id: null
  creature_name: Thug
  quantity: 4
  behavior_note: "Saqueadores oportunistas que ficaram para trás para limpar o que restou."
  xp_value: 100
  cr: "1/2"

## Validação SRD

- xp_total_encontro: 400
- orcamento_low: 1000
- orcamento_moderate: 1500
- orcamento_high: 2000
- classificacao: low
- aviso: null

## Navegação [OBRIGATÓRIO]
- [Voltar para Aventura Pai](../adventures/01-a-cacada-ao-culto.md)
- [Ver Mapa de Cenas](../scene-tree.md)
- [Próxima Cena: A Trilha da Floresta Sussurrante](./01-02-a-trilha-da-floresta-sussurrante.md)
