# A Câmara do Altar

- adventure_index: 2
- scene_index: 2
- slug: a-camara-do-altar
- location_id: dungeon
- description: |
  Um altar arcano brilha com uma luz púrpura profana. No centro, o vazio parece ganhar vida. O guardião das sombras não permitirá que ninguém avance.

## Pontos de Interesse

- nome: Altar Arcano
  tipo: object
  dc: 12
  skill: arcana
  success_text: "Você compreende como dissipar a energia que fortalece o guardião."
  failure_text: "A energia arcana repele seus sentidos, causando uma dor de cabeça aguda."

- nome: Parede Falsa
  tipo: hidden_passage
  dc: 20
  skill: investigation
  success_text: "Uma seção da parede desliza, revelando um estoque de armas consagradas."
  failure_text: "A alvenaria parece sólida e intransponível."

## Criaturas

- creature_id: null
  creature_name: Wraith
  quantity: 1
  behavior_note: "Utiliza sua habilidade de atravessar paredes para atacar e se esconder."
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
    Uma criatura com CR 5 pode eliminar um personagem de nível 3 com uma única ação.
