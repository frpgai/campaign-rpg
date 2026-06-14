# As Docas Sombrias

- adventure_index: 1
- scene_index: 1
- slug: as-docas-sombrias
- location_id: harbor
- description: |
  O grupo chega a Oakhaven sob uma névoa tão densa que mal se consegue ver um palmo à frente do nariz. O cheiro de sal e podridão é forte. No cais, vultos suspeitos se movem entre os caixotes.

## Pontos de Interesse

- nome: Baú Abandonado
  tipo: treasure
  dc: 15
  skill: investigation
  success_text: "Você encontra um mapa das passagens subterrâneas da cidade escondido sob um fundo falso."
  failure_text: "O baú contém apenas redes de pesca apodrecidas e lixo."

- nome: Rastro de Névoa
  tipo: hidden_passage
  dc: 15
  skill: perception
  success_text: "Você percebe que a névoa parece emanar de uma grade de bueiro específica, marcada com um símbolo estranho."
  failure_text: "A névoa parece estar em todo lugar, confundindo seus sentidos."

## Criaturas

- creature_id: null
  creature_name: Bandit
  quantity: 6
  behavior_note: "Saqueadores oportunistas que atacam quem entra na névoa."
  xp_value: 25
  cr: "1/8"

- creature_id: null
  creature_name: Thug
  quantity: 1
  behavior_note: "Líder dos bandidos, tenta flanquear os jogadores."
  xp_value: 100
  cr: "1/2"

## Validação SRD

- xp_total_encontro: 250
- orcamento_low: 600
- orcamento_moderate: 900
- orcamento_high: 1600
- classificacao: low
- aviso: null
