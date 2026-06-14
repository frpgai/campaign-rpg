# A Relíquia do Sol

- adventure_index: 2
- scene_index: 3
- slug: a-reliquia-do-sol
- location_id: dungeon
- description: |
  A câmara final contém um pedestal de ouro onde a Relíquia do Sol repousa. No entanto, o tesouro está cercado por objetos que não são o que parecem.

## Pontos de Interesse

- nome: Estátua
  tipo: object
  dc: 12
  skill: history
  success_text: "Você reconhece a estátua como sendo de um antigo herói que sacrificou tudo pela luz."
  failure_text: "Uma estátua imponente, mas sem significado aparente."

- nome: Baú Aberto
  tipo: treasure
  dc: null
  skill: null
  success_text: "Dentro do baú verdadeiro, moedas de ouro e gemas preciosas."
  failure_text: null

## Criaturas

- creature_id: null
  creature_name: Mimic
  quantity: 2
  behavior_note: "Disfarçados como baús de tesouro próximos ao altar."
  xp_value: 450
  cr: "2"

## Validação SRD

- xp_total_encontro: 900
- orcamento_low: 600
- orcamento_moderate: 900
- orcamento_high: 1600
- classificacao: moderate
- aviso: null
