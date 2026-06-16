# As Catacumbas Rúnicas

As catacumbas sob o Templo de Oakhaven exalam o frio da sepultura. O chão é composto por lajes de pedra escura cobertas de poeira e poças rasas de água condensada. Nas paredes, nichos arqueados abrigam restos mortais de antigos monges. A névoa necrótica aqui pulsa com uma tonalidade arroxeada mais viva, e sussurros distantes ecoam pelos corredores labirínticos, sussurrando promessas de poder e ameaças de morte.

**Função narrativa**: Testar as habilidades de exploração do grupo com armadilhas antigas, revelar passagens secretas e forçar os heróis a enfrentarem a vanguarda das forças de Malakor sob o novo patamar de nível 2.
**← Capítulo**: [Capítulo 2 — O Coração Sussurrante](index.md)

## Narração de Abertura

> *Leia ou parafraseie este texto quando os heróis chegarem:*
>
> Ao descerem os últimos degraus de pedra, o ar se torna gélido e pesado. A névoa púrpura envolve os seus pés enquanto vocês olham para o corredor escuro que se estende à frente. O silêncio das catacumbas é quebrado apenas pelo eco constante de água pingando do teto rochoso. Nas sombras além da luz das tochas, sussurros estranhos parecem chamar os seus nomes, e o som arrastado de passos e ossos indica que a morte patrulha estes corredores sagrados.

## Prompt de Mapa

> A top-down grid battlemap of a stone dungeon corridor inside ancient catacombs. Tall pillars carved with holy runes line the walls. Skeletons rest in small wall alcoves. In the center, a long hallway has a pressure plate trap. A hidden brick wall section in the top-right suggests a secret path. In the bottom-left, an iron chest sits partially buried in dust. Purple mist floats along the floor. Dim green and violet magical lighting. Detailed classic RPG fantasy style.

## Áreas

### A1. O Salão da Descida

A câmara inicial logo após a escadaria espiral do templo. O ar é úmido e o chão é escorregadio. É um ponto seguro para o grupo se organizar antes de adentrar os perigos das catacumbas, embora sussurros fantasmagóricos ainda possam ser ouvidos aqui.

### A2. O Corredor das Lâminas

Um corredor estreito e longo com pilares rústicos de pedra. Um fio de tripwire quase invisível cruza o caminho. Pisá-lo ativa um mecanismo nas paredes que dispara flechas velozes. Um grupo de esqueletos e zumbis patrulha a área oposta, esperando para emboscar quem ativar a armadilha.

### A3. A Galeria de Retratos

Uma antecâmara circular cujas paredes contêm afrescos desbotados dos antigos heróis do templo. Uma das paredes de tijolo está solta, escondendo uma passagem secreta que contorna o perigoso corredor das armadilhas e leva diretamente aos fundos da câmara de Malakor.

## NPCs Presentes

Nenhum NPC amigável nesta área. Apenas o eco distante e sussurrado da voz de Malakor ecoando na mente dos heróis à medida que se aproximam de sua tumba.

## Rumores (se os heróis ficarem e ouvirem)

*Se os heróis examinarem as inscrições nas paredes da Galeria de Retratos:*

- "O medalhão do sol purifica a corrupção necrótica se for tocado diretamente no núcleo do artefato."
- "Malakor foi sepultado com sua antiga espada cerimonial, que foi amaldiçoada para drenar a vida de quem for atingido por ela."

## Pontos de Interesse

| POI | Tipo | NPC ID (se Tipo = npc) | Skill | DC | Sucesso | Falha |
|---|---|---|---|---|---|---|
| `armadilha-de-flechas` | trap | NULL | Perception | 15 | Você avista o fio de disparo esticado rente ao chão. Com cuidado, você consegue desativar o mecanismo cortando a tensão do fio. | O fio estica contra seu tornozelo — um clique mecânico ecoa e uma rajada de flechas atinge o grupo. Todos na área sofrem 1d10 de dano perfurante (Salvaguarda de Destreza DC 12 reduz pela metade). |
| `parede-falsa` | hidden_passage | NULL | Investigation | 20 | Ao bater nos tijolos da Galeria de Retratos, você nota um som oco. Empurrando um tijolo com entalhe de sol, a parede gira, revelando uma passagem secreta livre de patrulhas. | A parede parece sólida e você não encontra nenhuma passagem. |
| `bau-das-catacumbas` | treasure | NULL | Investigation | 15 | Você abre o baú reforçado de ferro. Dentro dele, encontra duas poções de cura (*Potion of Healing*) e um pergaminho com a magia *Lesser Restoration*. | A fechadura continua trancada. Forçar sem a ferramenta adequada quebra a fechadura permanentemente. |

## Encontro

> *[SRD 5.2.1 — CC-BY-4.0]*

| Criatura | Quantidade | Modo | XP/PC | Dificuldade |
|---|---|---|---|---|
| `skeleton` | 1 | per_player | 50 | moderate |
| `zombie` | 1 | per_player | 50 | moderate |

## Nota do Mestre

Se os aventureiros encontrarem a parede falsa, eles podem evitar completamente o encontro de combate no Corredor das Lâminas e pegar os monstros pelas costas ou seguir direto para a câmara final de Malakor com vantagem de surpresa. Se o Sentinela Ronald estiver com o grupo, ele alertará os heróis sobre o perigo do tripwire no corredor.

## Transição de Saída

Atravessando o corredor das armadilhas ou usando a passagem secreta da parede falsa, os aventureiros chegam diante de uma imensa porta de ferro batido com entalhes de caveiras e runas necróticas brilhando em roxo — a entrada para o Sepulcro de Malakor.

---
## Navegação
- [Capítulo 2 — O Coração Sussurrante](index.md)
- [Próxima Cena: O Sepulcro de Malakor](02-o-sepulcro-de-malakor.md)
