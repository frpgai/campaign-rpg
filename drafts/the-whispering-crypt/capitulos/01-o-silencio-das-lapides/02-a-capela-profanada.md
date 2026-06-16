# A Capela Profanada

As portas duplas de madeira reforçada do Templo de Oakhaven dão acesso a um grande salão que outrora exalava reverência e incenso sagrado. Agora, o ambiente está na penumbra, iluminado apenas por vitrais estilhaçados que deixam passar a luz pálida da lua. Bancos de madeira estão derrubados, tapetes cerimoniais vermelhos estão rasgados e a névoa púrpura de Malakor pulsa a partir do altar principal, cobrindo o chão como tapete macabro.

**Função narrativa**: Enfrentar os zumbis dos monges caídos, interagir com o sentinela sobrevivente para obter ajuda e decifrar o mistério do Altar do Sol para revelar a entrada para as catacumbas.
**← Capítulo**: [Capítulo 1 — O Silêncio das Lápides](index.md)

## Narração de Abertura

> *Leia ou parafraseie este texto quando os heróis chegarem:*
>
> O ranger das pesadas portas de carvalho revela o interior devastado da capela. O outrora majestoso Salão de Preces está em ruínas. Pedaços de vitrais coloridos cobrem o chão como joias quebradas sob a luz da lua. No final do corredor central, diante de um altar de mármore envolto em fumaça púrpura, vultos arrastam os pés lentamente. Ao ouvir a sua entrada, as figuras se viram — seus rostos pálidos e carne em decomposição revelam que os clérigos do templo agora servem à morte.

## Prompt de Mapa

> A top-down grid battlemap of a ruined cathedral interior. Large stone pillars line the central aisle leading to a raised dais with a stone altar. Broken wooden pews are scattered across the floor, along with shards of colored glass. A faint purple mist floats near the altar in the top-middle. In the bottom-right, a small door leads to a closed vestry room. Beautiful, somber lighting with moonlight beams piercing through high arched windows. Detailed fantasy art style.

## Áreas

### A1. O Salão de Preces

O corredor central do templo, cercado por colunas de pedra e bancos virados. Três zumbis de monges corrompidos vagam por aqui, atacando imediatamente qualquer ser vivo que entre no templo.

### A2. O Altar do Sol

Um grande altar de mármore branco com entalhes dourados representando o nascer do sol. Atualmente, o altar está manchado com runas de sangue e exala a névoa necrótica de Malakor. Ele esconde o mecanismo da escadaria secreta, que só pode ser aberto ao purificar o altar ou decifrar os símbolos sagrados.

### A3. A Sacristia Trancada

Uma pequena sala de repouso no canto direito do templo, protegida por uma porta reforçada de madeira. O Sentinela Ronald se trancou aqui para tratar seus ferimentos graves provocados pelas garras dos mortos-vivos.

## NPCs Presentes

### Sentinela Ronald (Humano Guarda, Leal e Bom)

* **Aparência**: Um guerreiro robusto com armadura de placas levemente amassada e manchada de sangue. Ele está encostado em um baú de madeira, segurando uma bandagem improvisada no ombro esquerdo.
* **Personalidade**:
  * *Ideal*: Dever. A lei deve ser cumprida e o templo deve ser protegido acima de tudo.
  * *Vínculo*: Jurei defender os clérigos e o templo com a minha vida.
  * *Fraqueza*: Sou condescendente com quem parece fraco ou indefeso, arriscando minha própria segurança por eles.
* **O que sabe**: Ele tentou defender o altar, mas os mortos-vivos eram muitos. Ele viu os cultistas no passado ativando o mecanismo do altar colocando um medalhão solar específico no peito da estátua sagrada.
* **Como age**: Ronald está exausto e desconfiado de que os aventureiros sejam salteadores ou necromantes. Se os heróis o curarem (usando magia de cura ou um teste de *Medicine* DC 12) ou provarem suas boas intenções (teste de *Persuasion* DC 12), ele entregará o Medalhão do Sol que ele recuperou do altar para evitar que caísse em mãos erradas.

## Rumores (se os heróis ficarem e ouvirem)

*Se os heróis passarem tempo investigando a sacristia ou conversando com Ronald:*

- "Malakor não deseja apenas vingança, ele precisa de um sacrifício de sangue real para recuperar sua forma carnal completa."
- "As catacumbas abaixo de nós possuem armadilhas mecânicas antigas que respondem apenas a quem não carrega a marca do sol."

## Pontos de Interesse

| POI | Tipo | NPC ID (se Tipo = npc) | Skill | DC | Sucesso | Falha |
|---|---|---|---|---|---|---|
| `guarda-ferido` | npc | `guard` | NULL | NULL | Sentinela Ronald vigia a sacristia com a espada desembainhada. Ele aceita conversar se vir que vocês não são mortos-vivos. | NULL |
| `altar-do-sol` | object | NULL | Arcana | 12 | Você decifra os símbolos corrompidos. Ao canalizar um feitiço de luz ou usar o medalhão do sol na fechadura, o altar desliza para o lado, revelando a descida. | O altar emite uma faísca necrótica fria. Você sofre 1d4 de dano necrótico ao tocar os símbolos corrompidos. |
| `estatua-solar` | object | NULL | History | 12 | Você nota que a estátua representa a divindade solar e que suas mãos estendidas têm o encaixe perfeito para um medalhão circular. | A estátua parece apenas uma escultura antiga e empoeirada. |

## Encontro

> *[SRD 5.2.1 — CC-BY-4.0]*

| Criatura | Quantidade | Modo | XP/PC | Dificuldade |
|---|---|---|---|---|
| `zombie` | 1 | per_player | 50 | moderate |

## Nota do Mestre

Se o grupo não conseguir o medalhão com Ronald, eles podem forçar o mecanismo do altar com um teste muito difícil de *Strength (Athletics)* DC 20, ou usar ferramentas de ladino com *Dexterity (Thieves' Tools)* DC 18. Ronald pode se juntar ao grupo como aliado de combate temporário se for totalmente curado de seus ferimentos, ajudando no combate do Capítulo 2.

## Transição de Saída

Ao destravar o altar sagrado, o bloco de mármore desliza com um estrépito pesado de pedra contra pedra, revelando uma passagem com escadaria em espiral descendente. A névoa roxa sussurrante sobe das profundezas, convidando os heróis a entrarem nas catacumbas do Capítulo 2.

---
## Navegação
- [Capítulo 1 — O Silêncio das Lápides](index.md)
- [Próxima Cena: As Catacumbas Rúnicas](../../capitulos/02-o-coracao-sussurrante/01-as-catacumbas-runicas.md)
