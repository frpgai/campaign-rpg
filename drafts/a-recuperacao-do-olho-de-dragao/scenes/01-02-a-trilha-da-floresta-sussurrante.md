# A Trilha da Floresta Sussurrante

- adventure_index: 1
- scene_index: 2
- slug: a-trilha-da-floresta-sussurrante
- location_id: forest
- description: |
  A vegetação se torna densa e as árvores parecem sussurrar nomes esquecidos. O caminho é estreito e o cheiro de predadores paira no ar.

## Pontos de Interesse

- nome: Fissura na Árvore Antiga
  tipo: hidden_passage
  dc: 15
  skill: perception
  success_text: "Dentro da fissura, você encontra um amuleto em forma de olho, idêntico ao símbolo visto na vila. Ele brilha levemente quando apontado para o norte."
  failure_text: "A fissura parece ser apenas um abrigo para insetos."

- nome: Baú Perdido da Caravana
  tipo: treasure
  dc: 15
  skill: investigation
  success_text: "O baú contém um mapa antigo detalhando a localização de um templo subterrâneo nas proximidades, marcado com o selo do Culto."
  failure_text: "Você não consegue abrir o baú sem danificar o conteúdo ou simplesmente não encontra nada útil."

## Criaturas

- creature_id: null
  creature_name: Owlbear
  quantity: 1
  behavior_note: "Protege ferozmente seu território contra invasores."
  xp_value: 700
  cr: "3"

- creature_id: null
  creature_name: Wolf
  quantity: 2
  behavior_note: "Atacam em conjunto com a coruja-urso, aproveitando as distrações."
  xp_value: 50
  cr: "1/4"

## Validação SRD

- xp_total_encontro: 800
- orcamento_low: 1000
- orcamento_moderate: 1500
- orcamento_high: 2000
- classificacao: low
- aviso: null

## Navegação [OBRIGATÓRIO]
- [Voltar para Aventura Pai](../adventures/01-a-cacada-ao-culto.md)
- [Ver Mapa de Cenas](../scene-tree.md)
- [Próxima Cena: O Templo Esquecido](./01-03-o-templo-esquecido.md)
