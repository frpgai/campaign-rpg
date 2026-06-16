# O Sepulcro de Malakor

A câmara funerária mais profunda de Oakhaven é uma vasta sala circular sustentada por imensos pilares de pedra negra esculpida com runas sagradas agora rachadas e corrompidas. No centro da sala, sobre uma plataforma elevada de mármore, repousa um antigo altar de pedra escura que brilha com uma intensa pulsação roxa. Uma névoa espessa e gélida flutua no ar, e o espírito etéreo do General Malakor flutua acima do altar, sussurrando palavras de poder em uma língua esquecida enquanto gesticula em direção aos túmulos ao redor.

**Função narrativa**: O confronto final da campanha. Os heróis devem destruir o artefato necrótico para quebrar a imortalidade de Malakor e derrotá-lo antes que ele consiga possuir um corpo físico e iniciar sua marcha de destruição.
**← Capítulo**: [Capítulo 2 — O Coração Sussurrante](index.md)

## Narração de Abertura

> *Leia ou parafraseie este texto quando os heróis chegarem:*
>
> Vocês empurram as pesadas portas de ferro e o frio cortante do sepulcro atinge as suas peles. No centro da imensa câmara circular, uma coluna de fumaça púrpura e enxofre sobe de um altar de pedra negra. Flutuando na névoa, a figura etérea e sombria de Malakor ergue-se com olhos brilhando em um vermelho sangue. Sua voz ecoa em suas mentes como o roçar de metal enferrujado: "Tolos... Vocês vieram oferecer a carne que preciso para reclamar este mundo? Suas vidas pertencem à minha legião!"

## Prompt de Mapa

> A top-down grid battlemap of a large circular boss chamber inside a dark gothic crypt. In the center, a raised stone platform contains a large dark altar glowing with purple magical energy. In the corners, four black stone pillars are inscribed with glowing red runes. Stone sarcophagi are placed around the outer edge of the chamber. Thick violet fog fills the area. Epic and dark atmosphere. High quality, detailed digital painting fantasy art style.

## Áreas

### A1. O Círculo do Selo

A área de entrada da câmara, logo após as portas de ferro. É protegida por runas defensivas no chão que brilham levemente sob a névoa, mas a energia necrótica começou a enfraquecer o selo sagrado original de contenção.

### A2. A Plataforma do Altar

Uma elevação circular de mármore no centro da câmara. É aqui que o artefato sombrio (um cristal necrótico pulsante) está assentado sobre o altar de pedra, projetando o escudo espiritual que torna Malakor imune a danos físicos diretos.

### A3. Os Pilares de Contenção

Quatro grandes colunas de pedra negra que circundam a plataforma. Cada pilar canaliza energia necrótica da cripta para o altar. Os heróis podem investigar e quebrar as runas esculpidas nos pilares para sobrecarregar a energia do artefato central.

## NPCs Presentes

Nenhum NPC amigável presente na câmara. Se o Sentinela Ronald foi resgatado e curado no Capítulo 1, ele entra no combate ao lado dos heróis para segurar os esqueletos enquanto os jogadores focam no chefe e no altar.

## Rumores (se os heróis investigarem a estátua rúnica)

*Se os heróis conseguirem examinar a estátua funerária do General Malakor antes de iniciar o combate direto:*

- "O cristal necrótico é vulnerável a danos radiantes ou ao contato com o Medalhão do Sol do templo."
- "Cada pilar de contenção destruído reduz a defesa do espírito em 25%, tornando-o vulnerável a armas comuns."

## Pontos de Interesse

| POI | Tipo | NPC ID (se Tipo = npc) | Skill | DC | Sucesso | Falha |
|---|---|---|---|---|---|---|
| `cristal-necrotico` | object | NULL | Arcana | 15 | Você usa o Medalhão do Sol ou canaliza energia mágica para sobrecarregar o cristal. O artefato explode em estilhaços de luz, removendo as imunidades e reduzindo o HP de Malakor. | O altar emite uma descarga de energia fria que joga você para trás. Você sofre 1d6 de dano necrótico e fica caído (*prone*). |
| `estatua-de-malakor` | object | NULL | History | 15 | Você reconhece o ponto fraco na base da estátua que canaliza energia espiritual. Um golpe certeiro a derruba, interrompendo parte do fluxo de cura de Malakor. | Você não compreende a conexão rúnica e perde a ação de rodada. |

## Encontro

> *[SRD 5.2.1 — CC-BY-4.0]*

| Criatura | Quantidade | Modo | XP/PC | Dificuldade |
|---|---|---|---|---|
| `wraith` | 1 | per_player | 1800 | high |

### Comportamento do Chefe (Nota do Mestre)

> *[SRD 5.2.1 — CC-BY-4.0]*
>
> **Escala de Boss**: 
> - HP: 67 * num_players | XP Recompensa: 1800 * num_players.
>
> **Mecânica de Enfraquecimento**: 
> Enquanto o `cristal-necrotico` estiver ativo no altar, Malakor (Wraith) é imune a todo tipo de dano e pode usar sua ação para drenar vida dos heróis. 
> Se os jogadores destruírem o cristal usando o Medalhão do Sol ou um teste de *Arcana* (DC 15), o Wraith perde suas imunidades e passa a sofrer desvantagem em suas rolagens de ataque. Se a `estatua-de-malakor` for destruída (History DC 15 ou dano físico direto de 15 HP, AC 12), Malakor perde a habilidade de recuperar HP no início de cada rodada.

## Nota do Mestre

Se o grupo for de apenas 1 jogador, reduza o HP do Wraith para 40 e foque o combate na destruição do cristal. Incentive os jogadores a descreverem como usam os elementos do cenário para evitar os ataques do chefe, como esconder-se atrás das colunas de pedra para quebrar a linha de visão do Wraith.

## Transição de Saída

Com o golpe final no espírito de Malakor, a névoa púrpura começa a girar rapidamente em direção ao altar e se dissipa com um estalido de energia. O silêncio finalmente retorna ao cemitério de Oakhaven. O ar se torna limpo e quente novamente, indicando que a maldição foi quebrada e o general foi banido de volta ao descanso eterno.

---
## Navegação
- [Capítulo 2 — O Coração Sussurrante](index.md)
