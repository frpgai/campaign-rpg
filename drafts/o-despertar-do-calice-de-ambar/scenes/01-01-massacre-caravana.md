# Cena 1.1 — O Massacre da Caravana

**Local**: `cave` | **Função narrativa**: Apresentar os destroços da caravana e o primeiro combate.
**← Aventura**: [Ato 1 — Rastro de Sangue no Desfiladeiro](../adventures/01-rastro-de-sangue.md)

## Descrição Narrativa

O sol se põe atrás das montanhas, lançando sombras longas sobre os restos fumegantes da caravana. O cheiro de sangue e madeira queimada é forte. Corpos de guardas reais jazem espalhados, mas estranhamente, alguns parecem ter sido mortos por algo mais selvagem que uma simples flecha goblin. Alguns Goblins batedores ainda reviram os destroços, rindo enquanto disputam moedas de prata.

## Pontos de Interesse

- poi_slug: `bones-on-floor`
  name: Restos dos Guardas
  type: object
  skill: Investigation
  dc: 10
  flavor_text: Os corpos dos soldados estão desfigurados.
  success_text: Você percebe que as feridas não são de lâminas, mas de garras espirituais. A energia do cálice corrompeu o ar durante o ataque.
  failure_text: Você vê apenas corpos mortos em uma emboscada violenta.

- poi_slug: `locked-chest`
  name: Baú de Suprimentos
  type: treasure
  skill: Investigation
  dc: 15
  flavor_text: Um pequeno baú de ferro reforçado que os goblins não conseguiram abrir.
  success_text: Você abre o baú e encontra poções de cura e um mapa da Floresta dos Sussurros com anotações sobre o xamã.
  failure_text: O baú permanece trancado, apesar de seus esforços.

## Criaturas

- creature_name: Goblin
  quantity: 1
  quantity_mode: per_player
  behavior_note: Batedores covardes que tentam atacar pelas costas usando os destroços como cobertura.
  xp_value: 50
  cr: 1/4

## Transição Narrativa

Ao derrotar os batedores, vocês encontram uma trilha de pegadas pequenas e marcas de arraste que levam diretamente para a densa orla da floresta, onde o ar parece mais frio e pesado.

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro_por_pc: 50
- orcamento_low_por_pc: 25
- orcamento_moderate_por_pc: 50
- orcamento_high_por_pc: 75
- classificacao: moderate
- aviso: null

## Navegação [OBRIGATÓRIO]

- [Voltar para o Ato](../adventures/01-rastro-de-sangue.md)
- [Próxima Cena](../scenes/01-02-trilha-corrompida.md)
- [A História Completa](../story.md)
