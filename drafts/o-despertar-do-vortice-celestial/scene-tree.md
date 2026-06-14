# Árvore de Cenas

## Aventura 1 — A Floresta Sussurrante

- from: O Limiar da Floresta
  to:
    - cena: O Bosque das Aranhas
      condition: null
- from: O Bosque das Aranhas
  to:
    - cena: A Entrada do Templo
      condition: null
- from: A Entrada do Templo
  to:
    - cena: O Hall dos Ancestrais
      condition: "O guardião foi derrotado ou evadido"

## Aventura 2 — O Templo do Vórtice

- from: O Hall dos Ancestrais
  to:
    - cena: O Altar Arcano
      condition: null
- from: O Altar Arcano
  to:
    - cena: O Vórtice Celestial
      condition: "O segredo do altar foi descoberto"

## Navegação
- [Voltar para Campanha](./campaign.md)
