# A Entrada do Templo

- adventure_index: 1
- scene_index: 3
- slug: a-entrada-do-templo
- location_id: temple
- description: |
  As ruínas de um templo antigo emergem da floresta. A luz celestial que emana lá de dentro é ofuscante. Uma fera guardiã protege os degraus.

## Pontos de Interesse

- nome: Estátua
  tipo: object
  dc: 12
  skill: history
  success_text: A estátua representa um antigo guardião do cosmos, agora esquecido pelo tempo. [SRD 5.2.1 — CC-BY-4.0]
  failure_text: Você não reconhece a figura esculpida na pedra desgastada.

- nome: Símbolo Arcano
  tipo: ambience
  dc: null
  skill: null
  success_text: Runas brilham com uma pulsação rítmica, indicando que o portal está prestes a se tornar instável.
  failure_text: null

## Criaturas

- quantity_mode: per_player

- creature_id: null
  creature_name: Owlbear
  quantity: 0.25
  behavior_note: O Owlbear está imbuído de energia radiante e é extremamente agressivo.
  xp_value: 700
  cr: 3

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro: 175
- orcamento_low: 150
- orcamento_moderate: 225
- orcamento_high: 400
- classificacao: moderate
- aviso: null

## Navegação [OBRIGATÓRIO]
- [Cena Anterior](./01-02-o-bosque-das-aranhas.md)
- [Próxima Aventura](../adventures/02-o-templo-do-vortice.md)
