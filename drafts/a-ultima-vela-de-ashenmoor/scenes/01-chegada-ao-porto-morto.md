# A Chegada ao Porto Morto

- adventure_index: 1
- scene_index: 1
- slug: chegada-ao-porto-morto
- location_id: harbor (catálogo — confirmar UUID na persistência)
- status: FINALIZADA

## Descrição

O grupo desembarca em um cais silencioso. Cordas rangem, barcos batem contra as pilastras,
mas não há um único marinheiro à vista. Caixas empilhadas no cais, redes jogadas no chão,
uma lanterna apagada balançando no vento. No fundo da rua que sobe do porto, luzes nenhumas.

## Pontos de Interesse

- nome: Caixote Trancado
  tipo: object
  dc: 12
  skill: thieves_tools (ou Strength para forçar)
  success_text: "Dentro do caixote você encontra suprimentos de viagem e um bilhete dobrado: 'Não acendam nenhuma luz após o anoitecer. Eles seguem a chama.'"
  failure_text: "A fechadura resiste. O barulho metálico ecoa pelo cais vazio."

- nome: Passagem Oculta
  tipo: hidden_passage
  dc: 13
  skill: perception (ou investigation)
  success_text: "Atrás de um barril tombado, uma porta baixa de madeira leva a um corredor subterrâneo que sobe em direção ao centro da vila — uma rota alternativa que evita as ruas."
  failure_text: null

- nome: Pescador Informante
  tipo: npc
  dc: 11
  skill: persuasion (ou intimidation)
  success_text: "O velho pescador escondido sob o cais sussurra: 'Começou quando o faroleiro apagou o farol. Três noites atrás. Desde então eles andam pelas ruas. Não façam barulho. Não acendam fogo.'"
  failure_text: "O pescador recua assustado, fecha a escotilha e não abre mais. Você ouve ele rezando em voz baixa."

## Criaturas

Nenhuma criatura nesta cena.

## Validação SRD

- xp_total_encontro: 0
- classificacao: low (sem encontro)
- aviso: null

## Desbloqueios

- desbloqueia: Cena 2 "As Ruas do Silêncio" (sequencial automático)
- condition: null

---

**Navegação:**
- [Próxima Cena: As Ruas do Silêncio](./02-as-ruas-do-silencio.md)
- [Ver Resumo da Campanha](../campaign.md)
