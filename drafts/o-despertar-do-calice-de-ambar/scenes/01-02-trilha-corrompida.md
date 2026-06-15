# Cena 1.2 — A Trilha Corrompida

**Local**: `forest` | **Função narrativa**: Demonstrar o efeito da corrupção do cálice na fauna local.
**← Aventura**: [Ato 1 — Rastro de Sangue no Desfiladeiro](../adventures/01-rastro-de-sangue.md)

## Descrição Narrativa

A floresta se fecha sobre vocês como um túmulo verde. O silêncio é absoluto, interrompido apenas pelo estalar de galhos secos. A trilha dos Goblins é fácil de seguir, pois a vegetação ao redor parece ter murchado e morrido por onde o cálice passou. De repente, olhos amarelados brilham na escuridão entre as árvores.

## Pontos de Interesse

- poi_slug: `extinguished-campfire`
  name: Restos de Ritual
  type: ambience
  skill: Arcana
  dc: 12
  flavor_text: Uma fogueira apagada cercada por ossos de pássaros dispostos em círculo.
  success_text: O resíduo mágico confirma: Zog está usando o cálice para drenar a vida da floresta para fortalecer o ritual.
  failure_text: Parece apenas um acampamento rápido e desorganizado.

## Criaturas

- creature_name: Wolf
  quantity: 1
  quantity_mode: per_player
  behavior_note: Lobos com olhos injetados de verde, agindo sob influência mágica. Lutam até a morte.
  xp_value: 50
  cr: 1/4

## Transição Narrativa

Com as feras derrotadas, a trilha os leva a um pântano nebuloso onde cânticos guturais em dialeto goblin podem ser ouvidos à distância.

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro_por_pc: 50
- orcamento_low_por_pc: 25
- orcamento_moderate_por_pc: 50
- orcamento_high_por_pc: 75
- classificacao: moderate
- aviso: null

## Navegação [OBRIGATÓRIO]

- [Voltar para o Ato](../adventures/01-rastro-de-sangue.md)
- [Próxima Cena](../scenes/02-01-perimetro-murmuradores.md)
- [A História Completa](../story.md)
