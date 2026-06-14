# O Coração da Corrupção

- adventure_index: 1
- scene_index: 3
- slug: o-coracao-da-corrupcao
- location_id: dungeon
- description: |
  As passagens do esgoto levam a uma câmara de pedra antiga, onde a névoa é tão espessa que parece sólida. No centro, uma figura etérea e sombria flutua sobre um altar profanado, canalizando a escuridão.

## Pontos de Interesse

- nome: Altar Arcano
  tipo: object
  dc: 12
  skill: arcana
  success_text: "Você identifica que o altar está sendo usado como âncora para a Wraith. Destruí-lo pode enfraquecer a entidade."
  failure_text: "O altar emana um frio mortal que repele sua mão."

- nome: Estátua do Guardião
  tipo: object
  dc: 12
  skill: history
  success_text: "Esta estátua representa o antigo fundador da cidade, cuja linhagem foi amaldiçoada pela Wraith."
  failure_text: "Uma estátua desgastada e sem rosto."

## Criaturas

- creature_id: null
  creature_name: Wraith
  quantity: 1
  behavior_note: "O mestre da névoa. Tenta drenar a vida dos heróis e criar espectros se alguém morrer."
  xp_value: 1800
  cr: "5"

## Validação SRD

- xp_total_encontro: 1800
- orcamento_low: 600
- orcamento_moderate: 900
- orcamento_high: 1600
- classificacao: above_high
- aviso: |
    AVISO SRD — Encontro muito difícil [SRD 5.2.1 linhas 39411-39680 — CC-BY-4.0]
    XP do encontro: 1800 XP
    Orçamento High para grupo nível 3 (4 PCs): 1600 XP
    Este encontro excede o orçamento High em 12.5%.
    Uma criatura com CR 5 pode ser extremamente perigosa para personagens de nível 3 devido à sua resistência e dano.
