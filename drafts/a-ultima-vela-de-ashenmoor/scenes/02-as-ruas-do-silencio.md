# As Ruas do Silêncio

- adventure_index: 1
- scene_index: 2
- slug: as-ruas-do-silencio
- location_id: village (catálogo — confirmar UUID na persistência)
- status: FINALIZADA

## Descrição

Ruas de paralelepípedo cobertas por névoa baixa. Janelas fechadas. Portas barricadas por dentro.
Letreiros de taverna rangem no vento. No chão, marcas de arrasto no lodo — como se algo pesado
tivesse sido levado até aqui e depois se levantado sozinho. A vila está viva do jeito errado.

## Pontos de Interesse

- nome: Símbolo Arcano
  tipo: object
  dc: 13
  skill: arcana
  success_text: "O símbolo riscado na pedra é um selo de contenção — do tipo usado para manter os mortos em seus túmulos. Alguém o apagou deliberadamente. Com conhecimento. Não por acidente."
  failure_text: "O símbolo parece um rabisco sem sentido, mas algo nele te incomoda. Você não consegue tirar a imagem da cabeça."

- nome: Sobrevivente Escondido
  tipo: npc
  dc: 10
  skill: perception (para encontrar) ou persuasion (para convencer a falar)
  success_text: "Uma mulher escondida num barril d'água vazio diz em pânico: 'O faroleiro! Vi ele subindo a torre antes de tudo começar. Ele tinha um livro. Um livro que não deveria existir aqui.'"
  failure_text: "Você ouve algo se mexer dentro de um barril, mas quando se aproxima o som para. Seja lá o que for, não quer ser encontrado."

- nome: Beco sem Saída — Passagem Secreta
  tipo: hidden_passage
  dc: 14
  skill: investigation
  success_text: "Uma pedra solta na parede do beco revela um alçapão que desce para os esgotos da vila — e sobe, do outro lado, diretamente aos fundos do farol. Evita o encontro nas ruas."
  failure_text: null

## Criaturas

- creature_id: (confirmar UUID via GET /creatures?name=zombie na persistência)
  creature_name: Zombie
  quantity: 1
  quantity_mode: per_player (multiplicar pelo número de PCs na sessão)
  behavior_note: "Os zumbis patrulham as ruas em silêncio. Apenas atacam se o grupo acender uma fonte de luz visível (tocha, magia luminosa) ou fizer barulho alto. Um grupo furtivo pode evitar o confronto."
  xp_value: 50 (por unidade) [SRD 5.2.1 — CC-BY-4.0]
  cr: "1/4" [SRD 5.2.1 — CC-BY-4.0]

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

Cálculo exemplificado para 4 PCs (escala per_player):
- xp_total_encontro: 1 Zombie × 4 PCs × 50 XP = 200 XP
- orcamento_low (nível 1, 4 PCs): 50 × 4 = 200 XP
- orcamento_moderate (nível 1, 4 PCs): 75 × 4 = 300 XP
- orcamento_high (nível 1, 4 PCs): 100 × 4 = 400 XP
- classificacao: low (no limite)
- aviso: null

Para 1 PC (mínimo):
- xp_total_encontro: 50 XP | orcamento_low: 50 XP — classificacao: low

## Desbloqueios

- desbloqueia: Cena 3 "O Farol do Fim" (sequencial automático)
- condition: null

---

**Navegação:**
- [Voltar para Cena 1: A Chegada ao Porto Morto](./01-chegada-ao-porto-morto.md)
- [Próxima Cena: O Farol do Fim](./03-o-farol-do-fim.md)
- [Ver Resumo da Campanha](../campaign.md)
