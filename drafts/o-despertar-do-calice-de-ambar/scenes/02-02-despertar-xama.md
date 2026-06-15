# Cena 2.2 — O Despertar do Xamã (BOSS)

**Local**: `temple` | **Função narrativa**: Combate final contra Zog e a manifestação da alma orc.
**← Aventura**: [Ato 2 — O Ritual da Lua de Sangue](../adventures/02-ritual-lua-sangue.md)

## Descrição Narrativa

Zog, o Murmurador, está parado sobre um altar de pedra, segurando o Cálice de Âmbar acima de sua cabeça. A luz da lua atravessa o artefato, projetando uma sombra gigantesca de um guerreiro orc no chão. O ar está carregado de eletricidade estática. "A voz retornará! A Fronteira cairá!", ele grita, enquanto seus guarda-costas avançam contra vocês.

## Pontos de Interesse

- poi_slug: `arcane-altar`
  name: Altar de Zog
  type: object
  skill: Arcana
  dc: 15
  flavor_text: O altar está coberto de runas que canalizam a energia da lua para o cálice.
  success_text: Você consegue perturbar o fluxo mágico, dando desvantagem nas jogadas de ataque de Zog no próximo turno.
  failure_text: O fluxo mágico é forte demais e repele seu toque com um choque doloroso.

## Criaturas

- creature_name: Goblin
  quantity: 1
  quantity_mode: per_player
  behavior_note: |
    Guarda-costas fanáticos de Zog. 
    Zog (Boss) usa estatísticas de Goblin, mas com HP: 14 * num_players | XP: 100 * num_players.
    Ele ataca com raios esverdeados (1d6 dano arcano).
  xp_value: 100
  cr: 1/2

## Transição Narrativa

Com a queda de Zog, o brilho do cálice diminui até se tornar apenas uma pedra amarelada e inerte. A alma do orc foi selada novamente ou libertada para o descanso eterno. A floresta respira aliviada. Vocês retornam vitoriosos.

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro_por_pc: 100
- orcamento_low_por_pc: 25
- orcamento_moderate_por_pc: 50
- orcamento_high_por_pc: 75
- classificacao: high
- aviso: Este é o encontro final (Boss), planejado para ser desafiador.

## Navegação [OBRIGATÓRIO]

- [Voltar para o Ato](../adventures/02-ritual-lua-sangue.md)
- [Fim da Campanha]
- [A História Completa](../story.md)
