# O Farol do Fim

- adventure_index: 1
- scene_index: 3
- slug: o-farol-do-fim
- location_id: dungeon (catálogo — confirmar UUID na persistência)
- status: FINALIZADA

## Descrição

A torre do farol domina o promontório como um dedo de pedra apontado para o céu carregado.
A porta está arrombada de dentro para fora. Os degraus da escada em espiral estão cobertos
de cinzas e páginas arrancadas de algum livro. No topo, uma única chama queima — mas não
é a chama do farol. É menor. Mais escura. E pulsa como um coração.

## Pontos de Interesse

- nome: O Livro do Faroleiro
  tipo: object
  dc: 13
  skill: investigation
  success_text: "As páginas úmidas revelam que a chama no topo da torre não é fogo, mas uma fenda. O faroleiro tentou selar algo que veio do mar, mas o ritual foi corrompido. Para apagar a chama, é necessário o sangue de quem a acendeu ou um ato de sacrifício de luz pura."
  failure_text: "As letras parecem dançar e sangrar. Você entende apenas que o tempo é curto e que o faroleiro não é mais o dono desta torre."

- nome: A Chama Negra
  tipo: object
  dc: 15
  skill: religion
  success_text: "Você reconhece a pulsação: é um farol para o Plano das Sombras. Enquanto queimar, Ashenmoor continuará presa entre os mundos. Ela drena a vitalidade da cidade."
  failure_text: "O 'calor frio' da chama drena sua esperança. Você sente que desafiá-la sem o preparo correto é um erro fatal."

- nome: Silas, o Faroleiro
  tipo: npc
  dc: 12
  skill: persuasion
  success_text: "Silas está em transe, murmurando nomes de marinheiros perdidos. Se convencido de que o grupo veio ajudar, ele recupera a lucidez por um momento e revela que a chave da lanterna está escondida sob o altar."
  failure_text: "Silas apenas aponta para a chama e grita: 'Ela precisa ser alimentada!'. Ele avança com os dedos em garra, os olhos totalmente negros."

## Criaturas

- creature_id: (confirmar UUID via GET /creatures?name=shadow na persistência)
  creature_name: Shadow
  quantity: 1
  quantity_mode: fixed (Boss)
  behavior_note: "A Sombra emerge da Chama Negra quando o grupo tenta interagir com Silas ou com o Livro. Ela prioriza o personagem que carrega a maior fonte de luz."
  xp_value: 100 [SRD 5.2.1 — CC-BY-4.0]
  cr: "1/2" [SRD 5.2.1 — CC-BY-4.0]

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

Cálculo para 4 PCs (nível 1):
- xp_total_encontro: 100 XP
- orcamento_low: 200 XP
- orcamento_moderate: 300 XP
- orcamento_high: 400 XP
- classificacao: low (Encontro fácil para 4 pessoas, mas perigoso para 1)

## Desbloqueios

- Esta é a cena terminal (última da campanha)
- condition: null

---

**Navegação:**
- [Voltar para Cena 2: As Ruas do Silêncio](./02-as-ruas-do-silencio.md)
- [Ver Resumo da Campanha](../campaign.md)
- [Ver Revisão Final](../REVIEW.md)
