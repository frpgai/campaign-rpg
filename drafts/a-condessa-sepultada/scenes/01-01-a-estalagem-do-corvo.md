# Cena 1.1 — A Estalagem do Corvo

- adventure_order: 1
- scene_order: 1
- narrative_function: Estabelecer o tom de horror e a urgência da missão. O monge agonizante entrega o gancho central — ele presenciou o início do ritual e sabe onde fica a entrada dos subterrâneos. Revela a existência da Seita do Véu Eterno e que a cidade está em perigo.
- location_slug: tavern
- description: |
  A Estalagem do Corvo Cinza é a primeira parada de qualquer viajante que entra em Valdenmoor pela Porta Norte. Nesta noite — a mais longa do ano — a estalagem está anormalmente cheia. Moradores que não se sentem seguros em casa se amontoaram aqui, sussurrando sobre desaparecimentos e sinos que tocam sozinhos na catedral. O barman Gregor serve sem sorrir. No canto mais escuro da sala, um monge com hábito negro e manchas de sangue na testa está sentado, tremendo, murmurando palavras em latim arcaico. Ele está morrendo — e sabe de algo que ninguém mais sabe.

## Pontos de Interesse

- poi_slug: bartender-counter
  name: Balcão do Barman — Gregor, o Cinza
  type: npc
  skill: null
  dc: null
  flavor_text: "Gregor limpa o mesmo copo há dez minutos. Seus olhos evitam a janela que dá para a rua. 'Bebida é o que eu vendo. O que acontece lá fora não é problema meu — ainda.'"
  success_text: null
  failure_text: null

- poi_slug: informant-npc
  name: Irmão Taddeus — o Monge Agonizante
  type: npc
  skill: null
  dc: null
  flavor_text: "O monge levanta os olhos quando vocês se aproximam. Sua mão agarra o braço do mais próximo com força surpreendente para alguém tão pálido. 'A câmara... sob o altar... eles têm as três chaves agora. Ao amanhecer, ela desperta para sempre. Eu vi o sigilo... eu tentei destruí-lo...' Ele abre a mão — dentro, um fragmento de pergaminho carbonizado com um símbolo: um véu sobre um caixão."
  success_text: null
  failure_text: null

- poi_slug: game-table
  name: Mesa de Jogos — Conversas dos Moradores
  type: object
  skill: Investigation
  dc: 10
  flavor_text: "Quatro moradores jogam cartas sem ânimo. Repetem os mesmos rumores em círculo: 'O Mordechai desapareceu terça.' 'Minha vizinha viu hooded figures entrando pela catedral à meia-noite.' 'Dizem que a Condessa Vael era inocente — que o sacerdote a matou para usar o corpo dela como âncora.'"
  success_text: "Um dos jogadores, mais bêbado que os outros, mostra uma marca no pulso — o mesmo símbolo do pergaminho do monge, mas pequeno, como uma tatuagem recente. Ele não sabe explicar como apareceu. Está com febre."
  failure_text: "Os moradores param de falar quando percebem que estão sendo ouvidos. 'Não é da conta de estranhos.'"

- poi_slug: back-door
  name: Porta dos Fundos — Ruela dos Sumiços
  type: hidden_passage
  skill: Perception
  dc: 15
  flavor_text: "A porta dos fundos está entreaberta. Uma corrente de ar frio entra — e com ela, o cheiro de cera de vela e algo adocicado que não é bom."
  success_text: "Na ruela, há marcas de arrasto no barro — alguém foi levado daqui recentemente, não foi embora por vontade própria. As marcas levam em direção à catedral."
  failure_text: "A corrente de ar apaga algumas velas da estalagem. Gregor xinga baixinho e vai acendê-las de novo."

- poi_slug: locked-chest
  name: Baú Trancado — Pertences do Monge
  type: treasure
  skill: Investigation
  dc: 15
  flavor_text: "Sob o banco do monge Taddeus há um baú de couro simples com fechadura de ferro. Ele está inconsciente agora."
  success_text: "Dentro: um diário com entradas sobre a Seita do Véu Eterno, um esboço da planta baixa dos subterrâneos da catedral (incompleto mas utilizável), e uma chave de ferro enferrujada marcada com o número II. Uma das três chaves que o monge mencionou."
  failure_text: "A fechadura é mais resistente do que parece. Forçar o baú faz barulho — Gregor olha desconfiado."

## Criaturas

Nenhuma criatura nesta cena. O perigo é atmosférico e social — a ameaça está nas ruas, não dentro da estalagem.

## Transição Narrativa

O monge Taddeus perde a consciência antes de terminar de falar — ou morre nos braços dos heróis se o jogador não agir rápido o suficiente. Mas o fragmento de pergaminho e a chave II (se encontrada) são pistas concretas. As marcas de arrasto na ruela apontam para a catedral. Os heróis precisam ir às ruas — o amanhecer está chegando.

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro_por_pc: 0
- orcamento_low_por_pc: 50
- orcamento_moderate_por_pc: 75
- orcamento_high_por_pc: 100
- classificacao: null (cena social/investigativa — sem encontro de combate)
- aviso: null

## Navegação [OBRIGATÓRIO]

- [Voltar para o Ato 1](../adventures/01-o-veu-que-cai.md)
- [Próxima Cena — 1.2: As Ruas de Véu](./01-02-as-ruas-de-veu.md)
- [A História Completa](../story.md)
