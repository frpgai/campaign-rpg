# Cena 2.1 — A Descida

- adventure_order: 2
- scene_order: 1
- narrative_function: Revelar a escala do que a Seita construiu sob a cidade — os subterrâneos são antigos, deliberados, cheios de armadilhas que protegem o ritual. Aumentar a pressão: os heróis encontram evidências de que moradores da cidade foram trazidos para cá como "oferendas de vigília". Eliminar os guardas para abrir caminho até a câmara.
- location_slug: dungeon
- description: |
  A escotilha do Beco do Ferreiro desce por uma escada de pedra úmida até um corredor escavado diretamente sob a catedral. As paredes são de pedra antiga — mais antigas que a própria catedral, o que sugere que a estrutura foi construída sobre algo que já existia. Tochas com chama azul esverdeada iluminam o corredor a intervalos. No chão, um tapete de simbologia em giz — círculos concêntricos que levam em direção a uma câmara ao fundo. Às vezes, distante, uma voz feminina entoa algo em latim. Não é um canto bonito. O ar cheira a cera, sangue velho e pedra molhada.

## Pontos de Interesse

- poi_slug: pressure-trap
  name: Armadilha de Pressão — Placa de Pedra Desnivelada
  type: trap
  skill: Investigation
  dc: 15
  flavor_text: "Um trecho do corredor tem o chão levemente diferente dos demais — a pedra não encaixa perfeitamente. Qualquer um que passar sem notar ativa a armadilha."
  success_text: "A placa é identificada antes de ser ativada. Pode ser contornada passando rente à parede (Athletic DC 10) ou desativada removendo um pino de ferro na lateral (Thieves' Tools DC 12). Se desativada: o grupo passa em silêncio — os guardas à frente não recebem alerta."
  failure_text: "A placa afunda com um clique seco. Dardos de osso disparam da parede — 1d4 piercing para cada personagem que estiver no trecho (sem save). O barulho alerta as criaturas do corredor."

- poi_slug: bones-on-floor
  name: Ossos no Chão — Câmara Lateral de 'Vigília'
  type: object
  skill: Investigation
  dc: 10
  flavor_text: "Uma câmara lateral sem porta, fechada por uma grade de ferro. Dentro, ossos humanos organizados em círculo — não atirados, arranjados. No centro, um medalhão de prata."
  success_text: "O medalhão tem uma inscrição: 'Mordechai Voss — Guarda da Porta Norte'. É o guarda desaparecido que os moradores mencionaram na estalagem. Ele foi o primeiro. Os ossos são recentes — de dias atrás, não anos. Isso significa que o ritual de 'preparação' já ceifou vidas. O medalhão pode servir como evidência ou como item de retorno à família."
  failure_text: "Ossos velhos em câmara velha. Nada de especial à primeira vista."

- poi_slug: arcane-symbol
  name: Símbolo Arcano — O Terceiro Sigilo
  type: ambience
  skill: null
  dc: null
  flavor_text: "Na parede antes da câmara final, um sigilo enorme traçado em substância escura (sangue seco, não tinta). Pulsa levemente com uma luz fraca que aumenta e diminui como uma respiração. Isso é o que o monge Taddeus tentou destruir — e falhou."
  success_text: null
  failure_text: null

- poi_slug: locked-chest
  name: Baú Trancado — Suprimentos da Guarda
  type: treasure
  skill: Investigation
  dc: 15
  flavor_text: "Encostado na parede, um baú de ferro com cadeado pesado — suprimentos que a Seita trouxe para seus guardas."
  success_text: "2 Poções de Cura (2d4+2 HP cada), uma lanterna com 3 horas de óleo, e uma nota: 'A Condessa acorda com o quinto sino. Não deixem ninguém sair pelos corredores após o quarto.' — o quinto sino ainda não tocou. O grupo tem tempo, mas pouco."
  failure_text: "O cadeado é de qualidade militar. Não cede sem a chave certa ou ferramentas especializadas."

- poi_slug: arcane-altar
  name: Altar Arcano — Posto de Comando da Seita
  type: object
  skill: Arcana
  dc: 12
  flavor_text: "Um altar menor no corredor — não o altar principal, mas um posto avançado usado para coordenar o ritual. Mapas, velas e um círculo de comunicação traçado na pedra."
  success_text: "O círculo é um receptor de instruções arcanas — e a última mensagem ainda está impressa nele em luz tênue: 'Chave III com a Madre. Câmara selada até o quinto sino. Condessa está acordando mais cedo do que previsto — acelerem.' A Chave III está com um dos cultistas nesta cena, não na câmara."
  failure_text: "O círculo é só decoração ritual ao olhar desatento. Parece inativo."

## Criaturas

- creature_name: Thug
  quantity: 1
  quantity_mode: per_player
  behavior_note: |
    Guardas humanos da Seita — ex-soldados ou mercenários contratados, não fanáticos. Lutam para proteger o corredor mas recuam se o grupo reduzir metade deles (Morale Break). Se capturados e interrogados (Intimidation DC 12), revelam que a Chave III está com a "Madre Serafella" na câmara principal e que a Condessa "ainda não está totalmente acordada — o quinto sino é o gatilho". Informação valiosa para a negociação na Cena 2.2.
  xp_value: 100
  cr: "1/2"

- creature_name: Skeleton
  quantity: 1
  quantity_mode: per_player
  behavior_note: |
    Esqueletos animados pela Condessa Sepultada como guardiões silenciosos do corredor. Não falam, não recuam, não se intimidam — lutam até destruídos. Posicionados mais fundo no corredor, próximos ao sigilo arcano. Se a armadilha de pressão for ativada, os esqueletos avançam imediatamente pelo corredor em direção ao barulho.
  xp_value: 50
  cr: "1/4"

## Transição Narrativa

Com os guardas eliminados e o corredor limpo, o grupo está diante da câmara final. O sigilo na parede pulsa mais forte — a Condessa está acordando. O quinto sino não tocou ainda. A Chave III está dentro, com a Madre Serafella. Ao fundo do corredor, luz vermelha vaza sob uma porta de pedra pesada entalhada com o mesmo símbolo do véu. Do outro lado: vozes em latim, muitas, em uníssono.

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- xp_total_encontro_por_pc: 150
  - Thug: 100 XP x 1 por jogador = 100 XP/PC
  - Skeleton: 50 XP x 1 por jogador = 50 XP/PC
  - Total: 150 XP/PC
- orcamento_low_por_pc: 50
- orcamento_moderate_por_pc: 75
- orcamento_high_por_pc: 100
- classificacao: high (150 XP/PC vs. High = 100 XP/PC)
- aviso: "AVISO — encontro 50% acima do budget High para nível 1 (150 XP/PC vs. 100 XP/PC). Mestre deve considerar: (a) separar os grupos de criaturas em ondas com espaço para recuperação, (b) reduzir para 1 Thug total + 1 Skeleton/PC, ou (c) aceitar como encontro difícil intencional para criar pressão de clímax. [SRD 5.2.1 — CC-BY-4.0]"

## Navegação [OBRIGATÓRIO]

- [Voltar para o Ato 2](../adventures/02-a-camara-da-condessa.md)
- [Cena Anterior — 1.2: As Ruas de Véu](./01-02-as-ruas-de-veu.md)
- [Próxima Cena — 2.2: O Ritual](./02-02-o-ritual.md)
- [A História Completa](../story.md)
