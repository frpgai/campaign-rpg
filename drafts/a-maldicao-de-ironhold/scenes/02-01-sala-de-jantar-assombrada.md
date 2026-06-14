# Sala de Jantar Assombrada

- adventure_index: 2
- scene_index: 1
- slug: sala-de-jantar-assombrada
- location_id: temple
- description: |
  Uma longa mesa de carvalho está posta para um banquete que nunca terminou. Pratos de prata estão cobertos por séculos de poeira e teias de aranha.

## Pontos de Interesse

- nome: NPC Informante
  tipo: npc
  dc: 14
  skill: persuasion
  success_text: O espírito de um antigo mordomo revela que a chave da Capela está escondida no lustre.
  failure_text: O espírito apenas lamenta o jantar frio e se recusa a falar sobre qualquer outra coisa.

- nome: Mesa de Jogos
  tipo: object
  dc: 12
  skill: investigation
  success_text: Você encontra um baralho de cartas mágicas que pode conceder uma pequena vantagem.
  failure_text: Você encontra apenas dados viciados e cartas manchadas.

## Criaturas

- creature_id: thug
  creature_name: Bandidos Espectrais
  quantity: 4
  behavior_note: Mercenários que morreram na fortaleza e agora protegem os tesouros do Duque.
  xp_value: 100
  cr: 1/2

## Validação SRD

- xp_total_encontro: 400
- orcamento_low: 2000
- orcamento_moderate: 3000
- orcamento_high: 4400
- classificacao: low
- aviso: null
