# Cena 1.2 — As Ruas de Véu

- adventure_order: 1
- scene_order: 2
- narrative_function: Revelar que a Seita do Véu Eterno já age abertamente pelas ruas de Valdenmoor — a cidade está sendo tomada. Entregar pistas adicionais sobre o ritual (os três sigilos, a localização da entrada nos subterrâneos) e forçar o primeiro confronto de combate, calibrando o perigo que os heróis enfrentarão na câmara.
- location_slug: village
- description: |
  As ruas de Valdenmoor à meia-noite são um labirinto de névoa baixa e luz de archote que mal alcança o chão. A catedral de pedra negra domina o horizonte em qualquer direção — seus sinos tocam sozinhos em intervalos irregulares. Figuras encapuzadas se movem em grupos de dois ou três, distribuindo algo pelas portas das casas — não batem, apenas deixam e seguem. Um dos moradores que abriu a porta para receber o embrulho ficou parado no limiar com expressão vazia, e depois voltou para dentro sem fechar a porta. Há uma urgência silenciosa no ar: o ritual está progredindo.

## Pontos de Interesse

- poi_slug: informant-npc
  name: Criança no Beiral — Mira, 9 anos
  type: npc
  skill: null
  dc: null
  flavor_text: "Uma menina sentada no beiral de um telhado baixo observa tudo com olhos muito abertos. Não desce — diz que não é seguro no nível da rua. 'Aqueles de capuz levaram meu pai esta tarde. Foram para baixo da catedral — tem uma escotilha no beco do Ferreiro, atrás da forja. Eu vi.'"
  success_text: null
  failure_text: null

- poi_slug: extinguished-campfire
  name: Fogueira Apagada — Posto de Guarda Abandonado
  type: ambience
  skill: null
  dc: null
  flavor_text: "O posto de guarda da Rua do Mercado está vazio. A fogueira foi apagada de propósito — as brasas jogadas fora, não extintas. As armaduras dos guardas estão dobradas no chão, cuidadosamente, como se tivessem sido tiradas. Os guardas não lutaram para sair."
  success_text: null
  failure_text: null

- poi_slug: locked-chest
  name: Baú de Distribuição — Embrulhos da Seita
  type: treasure
  skill: Investigation
  dc: 15
  flavor_text: "Um dos cultistas derrubou um baú de madeira ao virar a esquina. Ele continuou andando sem olhar para trás."
  success_text: "Dentro do baú: dezenas de amuletos de osso com o símbolo do véu, uma lista com endereços da cidade (nomes de moradores, cada um com uma marca de visto quando o amuleto foi entregue), e um bilhete: 'Todas as âncoras em posição antes do quarto sino. A Condessa não perdoa atrasos.' Ao fundo, enterrada sob os amuletos: a Chave I — idêntica à chave II do monge, mas numerada."
  failure_text: "A fechadura é reforçada com cobre. Forçar em silêncio não é possível — e os cultistas na rua estão perto."

- poi_slug: back-door
  name: Porta dos Fundos — Beco do Ferreiro
  type: hidden_passage
  skill: Perception
  dc: 15
  flavor_text: "A forja do ferreiro está fria e abandonada. No beco atrás dela, paralelepípedos irregulares cobrem o chão — mas um deles tem marcas de uso recente nas bordas."
  success_text: "A escotilha. Confirma o que Mira disse — e leva diretamente aos subterrâneos da catedral (Cena 2.1). Em volta da abertura, símbolos traçados em cinza que se iluminam levemente ao toque. Um aviso ou uma armadilha."
  failure_text: "O beco parece um beco comum. A escotilha está camuflada demais para ser encontrada sem dica."

## Criaturas

- creature_name: Cultist
  quantity: 1
  quantity_mode: per_player
  behavior_note: |
    Cultistas da Seita do Véu Eterno em patrulha de distribuição. Quando confrontados, tentam fugir em direção à catedral para dar alarme antes de lutar — capturá-los vivos permite interrogação (eles sabem sobre a escotilha e o terceiro sino). Fanáticos: não negociam, mas podem ser intimidados (Intimidation DC 14) para revelar o horário do ritual.
  xp_value: 25
  cr: "1/8"

## Transição Narrativa

Com a escotilha encontrada (e cultistas derrotados ou evitados), os heróis têm a rota de entrada. O quarto sino da catedral começa a tocar ao longe — Mira grita do telhado: "É o quarto! Corre!" O amanhecer está a horas. A escotilha é o caminho para o Ato 2.

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro_por_pc: 25
  - Base: 1 Cultist (25 XP) x 1 por jogador = 25 XP por PC
- orcamento_low_por_pc: 50
- orcamento_moderate_por_pc: 75
- orcamento_high_por_pc: 100
- classificacao: low
- aviso: null — encontro de 25 XP/PC está abaixo do budget Low (50). Encontro propositalmente leve para conservar recursos para o clímax no Ato 2.

## Navegação [OBRIGATÓRIO]

- [Voltar para o Ato 1](../adventures/01-o-veu-que-cai.md)
- [Cena Anterior — 1.1: A Estalagem do Corvo](./01-01-a-estalagem-do-corvo.md)
- [Próxima Cena — 2.1: A Descida](./02-01-a-descida.md)
- [A História Completa](../story.md)
