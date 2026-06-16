# O Cemitério Esquecido

Os heróis chegam aos limites do Templo de Oakhaven sob o manto de uma noite sem estrelas. O pátio do cemitério, outrora um local sagrado e bem cuidado, agora jaz em um silêncio sepulcral, quebrado apenas pelo sopro de um vento gelado que agita as copas das árvores. Uma névoa roxa, espessa e com cheiro de enxofre e terra molhada, rasteja rente ao chão, cobrindo os túmulos e ocultando perigos que espreitam nas sombras.

**Função narrativa**: Apresentar os primeiros perigos da névoa necrótica, resgatar o coveiro sobrevivente e descobrir que os clérigos do templo se trancaram na capela central.
**← Capítulo**: [Capítulo 1 — O Silêncio das Lápides](index.md)

## Narração de Abertura

> *Leia ou parafraseie este texto quando os heróis chegarem:*
>
> A névoa roxa gélida sobe até a altura dos seus joelhos enquanto vocês cruzam o portão de ferro retorcido do cemitério de Oakhaven. O silêncio é opressivo e o ar carrega um odor pungente de terra revirada e decomposição. Ao longe, entre lápides tortas e silhuetas de árvores secas, vultos brancos e magros parecem se mover lentamente, e o som sinistro de ossos batendo contra o chão de pedra ecoa na escuridão.

## Prompt de Mapa

> A top-down grid battlemap of a dark, gothic cemetery at night. In the center, there are rows of crumbling stone tombstones, cracked sarcophagi, and withered bare trees. A thick purple mist covers the ground. In the top-left, there is a small stone mausoleum with a heavy iron door. In the top-right, a large iron gate leads to a stone temple path. Moody dark lighting with moonlight casting long shadows. Hand-drawn detailed fantasy style.

## Áreas

### A1. O Caminho das Lápides

O pátio principal do cemitério, repleto de túmulos antigos e terra recentemente revirada. A névoa aqui é mais densa, dificultando a visão além de alguns metros. É nesta área que as patrulhas de esqueletos de Malakor buscam por intrusos.

### A2. O Mausoléu do Coveiro

Uma pequena capela de pedra cinzenta usada para armazenar ferramentas e sepultar a família do coveiro. A pesada porta de ferro está encostada. O coveiro Kael se escondeu aqui dentro após o início dos ataques, apavorado com as criaturas lá fora.

### A3. O Portão Lateral do Templo

Um portão de ferro ornamentado com símbolos sagrados do sol, que dá acesso à capela central do templo. O portão está trancado por dentro com uma corrente pesada, e marcas de garras e sangue seco cobrem as barras de metal.

## NPCs Presentes

### Coveiro Kael (Humano Informante, Neutro)

* **Aparência**: Um homem encurvado, de meia-idade, com roupas sujas de terra e mãos calejadas. Seus olhos arregalados de pânico se movem constantemente de um lado para o outro.
* **Personalidade**: 
  * *Ideal*: Neutralidade. A informação não tem lado; ele só quer sobreviver à noite.
  * *Vínculo*: Devo uma grande dívida ao abade do templo e por isso não fugi da vila ainda.
  * *Fraqueza*: Vendo informações para quem pagar a maior quantia em ouro, pois precisa pagar seus credores.
* **O que sabe**: Ele viu os mortos se erguerem logo após o tremor de terra. Ele sabe que o Abade e os clérigos sobreviventes se trancaram dentro da capela central, mas a chave do portão lateral foi perdida no cemitério durante a fuga dos esqueletos.
* **Como age**: Ele está extremamente arisco e desconfiado. Se os aventureiros forem hostis, ele se trancará no mausoléu. Se oferecerem moedas ou proteção, ele compartilhará de bom grado o que sabe.

## Rumores (se os heróis ficarem e ouvirem)

*Se os heróis passarem tempo investigando as lápides ou conversando com Kael, podem ouvir:*

- "A névoa não apenas ergue os mortos, ela sussurra nomes de antigos tiranos nas mentes daqueles que a respiram por muito tempo."
- "O Abade carregava uma relíquia sagrada do sol que mantinha as catacumbas protegidas, mas ela parece ter perdido o brilho quando a terra tremeu."
- "Há um túmulo mais antigo, perto do grande salgueiro, que foi completamente destruído de dentro para fora, como se algo tivesse cavado seu caminho para a superfície."

## Pontos de Interesse

| POI | Tipo | NPC ID (se Tipo = npc) | Skill | DC | Sucesso | Falha |
|---|---|---|---|---|---|---|
| `coveiro-escondido` | npc | `informant` | NULL | NULL | O coveiro espreita pela fresta do mausoléu. Ele sussurra pedindo ajuda e promete contar o que sabe em troca de proteção. | NULL |
| `tumulos-violados` | object | NULL | Investigation | 10 | Você encontra os restos de um guarda do templo. Em sua bolsa, há 15 peças de ouro e um frasco com água benta intacta. | Você apenas encontra roupas podres e ossos velhos sob a névoa fria. |
| `fogueira-abandonada` | ambience | NULL | NULL | NULL | Cinzas ainda quentes de uma fogueira de patrulha e restos de escudos quebrados mostram que uma batalha violenta ocorreu aqui poucas horas atrás. | NULL |
| `portao-trancado` | hidden_passage | NULL | Perception | 15 | Você percebe que o cadeado do portão lateral está quebrado, mas preso por uma chave enferrujada que emperrou dentro da fechadura. Um teste forte de atletismo ou ferramentas de ladino pode abri-lo. | O portão parece completamente intransponível à primeira vista sob a névoa escura. |

## Encontro

> *[SRD 5.2.1 — CC-BY-4.0]*

| Criatura | Quantidade | Modo | XP/PC | Dificuldade |
|---|---|---|---|---|
| `skeleton` | 1 | per_player | 50 | moderate |

## Nota do Mestre

Se os jogadores decidirem evitar o combate com os esqueletos, eles podem usar testes de *Stealth* (DC 12) para se esgueirar pelas sombras das lápides. Se falharem, os esqueletos ouvem o barulho e atacam de surpresa. O coveiro Kael pode ser subornado com pelo menos 5 PO para revelar a localização exata da chave reserva do cemitério que ele escondeu perto de uma das estátuas.

## Transição de Saída

Ao derrotar os esqueletos ou destrancar o portão de ferro com a ajuda do coveiro, os aventureiros conseguem subir os degraus de pedra do templo e alcançar a entrada principal da capela central, iniciando a próxima cena.

---
## Navegação
- [Capítulo 1 — O Silêncio das Lápides](index.md)
- [Próxima Cena: A Capela Profanada](02-a-capela-profanada.md)
