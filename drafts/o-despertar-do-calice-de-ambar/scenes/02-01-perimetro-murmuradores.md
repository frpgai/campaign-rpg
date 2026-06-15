# Cena 2.1 — O Perímetro dos Murmuradores

**Local**: `forest` | **Função narrativa**: Abordagem tática ao acampamento inimigo.
**← Aventura**: [Ato 2 — O Ritual da Lua de Sangue](../adventures/02-ritual-lua-sangue.md)

## Descrição Narrativa

Vocês alcançam a borda do acampamento. Cabanas de couro e espinhos cercam uma clareira central onde uma grande pira queima com chamas esverdeadas. Vários Goblins patrulham o perímetro, e armadilhas rudimentares, mas letais, estão escondidas sob as folhas.

## Pontos de Interesse

- poi_slug: `pressure-trap`
  name: Armadilha de Estacas
  type: trap
  skill: Investigation
  dc: 15
  flavor_text: Folhas secas dispostas de forma suspeita no caminho principal.
  success_text: Você identifica o mecanismo e desativa a armadilha, permitindo uma passagem segura.
  failure_text: Se alguém pisar, sofre 1d6 de dano de estacas e alerta os guardas.

- poi_slug: `informant-npc`
  name: Prisioneiro Humano
  type: npc
  skill: Persuasion
  dc: 12
  flavor_text: Um guarda da caravana que sobreviveu e está amarrado a uma árvore.
  success_text: Ele revela que Zog está fraco durante o ritual e que um ataque lateral pelas sombras é a melhor estratégia.
  failure_text: O prisioneiro está em choque e apenas balbucia incoerências.

## Criaturas

- creature_name: Goblin
  quantity: 1
  quantity_mode: per_player
  behavior_note: Sentinelas alertas. Um deles tentará correr para a clareira central para avisar Zog se o combate durar mais de 3 turnos.
  xp_value: 50
  cr: 1/4

## Transição Narrativa

Superando a segurança externa, o caminho para o centro do ritual está aberto. O ar vibra com o grito do xamã orc tentando escapar de sua prisão de âmbar.

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro_por_pc: 50
- orcamento_low_por_pc: 25
- orcamento_moderate_por_pc: 50
- orcamento_high_por_pc: 75
- classificacao: moderate
- aviso: null

## Navegação [OBRIGATÓRIO]

- [Voltar para o Ato](../adventures/02-ritual-lua-sangue.md)
- [Próxima Cena](../scenes/02-02-despertar-xama.md)
- [A História Completa](../story.md)
