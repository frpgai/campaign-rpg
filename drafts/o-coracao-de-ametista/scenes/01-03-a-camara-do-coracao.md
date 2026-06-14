# A Câmara do Coração

- adventure_index: 1
- scene_index: 3
- slug: a-camara-do-coracao
- location_id: dungeon
- description: |
  A câmara final é ampla, com um altar central banhado por uma luz roxa pulsante. O Coração de Ametista flutua sobre o altar, mas algo monstruoso espreita na escuridão acima.

## Pontos de Interesse

- nome: Altar Arcano
  tipo: object
  dc: 12
  skill: arcana
  success_text: Você reconhece que o altar está drenando energia das sombras ao redor para fortalecer a joia.
  failure_text: Você não entende o funcionamento do altar.

- nome: Estátua da Rainha
  tipo: object
  dc: 12
  skill: history
  success_text: A estátua representa a Rainha Prateada, que jurou proteger Oakhaven mesmo após a morte.
  failure_text: É apenas uma estátua antiga e majestosa.

## Criaturas

- creature_id: owlbear
  creature_name: Owlbear
  quantity: 1
  behavior_note: Uma fera corrompida pela energia da tumba. Ataca qualquer um que se aproxime do altar.
  xp_value: 700
  cr: 3

- creature_id: skeleton
  creature_name: Skeleton
  quantity: 2
  behavior_note: Servem como guardiões menores, distraindo os inimigos do Owlbear.
  xp_value: 50
  cr: 1/4

## Validação SRD

- xp_total_encontro: 800
- orcamento_low: 600
- orcamento_moderate: 900
- orcamento_high: 1600
- classificacao: moderate
- aviso: null
