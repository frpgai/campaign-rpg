# Salão do Trono

- adventure_index: 2
- scene_index: 4
- slug: salao-do-trono
- location_id: temple
- description: |
  O vasto salão é dominado por um trono de pedra negra. Sobre ele, a alma do Duque flutua, presa por correntes de luz púrpura que emanam de um selo no chão. Uma figura pálida e sedenta de sangue observa do trono.

## Pontos de Interesse

- nome: Selo Arcano
  tipo: object
  dc: 18
  skill: arcana
  success_text: Com um último esforço e as palavras certas, o selo se estilhaça, libertando o Duque e enfraquecendo seus captores.
  failure_text: O selo repele sua magia, causando um choque que drena suas forças.

- nome: Trono do Duque
  tipo: object
  dc: 15
  skill: history
  success_text: Você percebe que o trono contém a linhagem real gravada, e invocar o nome dos ancestrais pode ajudar a quebrar a maldição.
  failure_text: É apenas uma cadeira de pedra fria e amedrontadora.

## Criaturas

- creature_id: vampire-spawn
  creature_name: O Usurpador Pálido
  quantity: 1
  behavior_note: O líder espectral que tomou o trono. Ele usa sua agilidade e sede de sangue para dizimar invasores.
  xp_value: 1800
  cr: 5

- creature_id: ghost
  creature_name: Conselheiros Espectrais
  quantity: 2
  behavior_note: Protegem o Usurpador e tentam amaldiçoar os heróis.
  xp_value: 1100
  cr: 4

## Validação SRD

- xp_total_encontro: 4000
- orcamento_low: 2000
- orcamento_moderate: 3000
- orcamento_high: 4400
- classificacao: high
- aviso: null
