# Revisão de Campanha — A Maldição do Curandeiro de Thornwick

## Resumo de Estado

- **Objetivo**: Libertar a aldeia de Thornwick das criaturas que emergem do cemitério toda noite antes que os sobreviventes sejam consumidos.
- **Antagonista**: A Maldição de Aldric — força autônoma sem consciência, eco da dor e raiva do curandeiro morto, que anima os mortos do cemitério.
- **Stakes**: A maldição se espalhará para as vilas vizinhas pelo rio subterrâneo se não for desfeita.
- **Tom**: Sombrio
- **Duração**: long (~2 horas) | `duration_hint: long`
- **Nível Início**: 1 | **Nível Fim**: 2
- **Jogadores Estimados**: 1–4
- **Visibilidade**: pública
- **Slug**: a-maldicao-de-thornwick

## Progresso da Criação

- **Fases Concluídas**: Fase 1 (Núcleo Narrativo), Fase 2 (Duração), Fase 3 (Capítulos), Fase 4 (Cenas), Fase 5 (Transições), Fase 6 (Identidade e Revisão Final)
- **Fase Atual**: COMPLETA — todos os arquivos de rascunho gerados e salvos.
- **Último Ponto de Parada**: Campanha completa. Aguarda decisão do Mestre para gravar no banco de dados.

## Dados Coletados

```
name            = "A Maldição do Curandeiro de Thornwick"
slug            = "a-maldicao-de-thornwick"
objective       = "Libertar a aldeia de Thornwick das criaturas que emergem do cemitério toda noite antes que os sobreviventes sejam consumidos."
conflict_origin = "Aldric, curandeiro exilado injustamente, gravou uma maldição no cemitério antes de morrer. A maldição dormiu por gerações e acordou quando o último ancião que testemunhou o exílio foi enterrado no cemitério."
antagonist      = "A Maldição de Aldric — força autônoma sem consciência, eco da dor e raiva do curandeiro morto, que anima os mortos do cemitério."
failure_stakes  = "A maldição se espalhará para as vilas vizinhas pelo rio subterrâneo."
tone            = "sombrio"
duration_hint   = "long"
level_start     = 1
level_end       = 2
players_min     = 1
players_max     = 4
visibility      = "public"
cover_image     = null (gerar com prompt incluído em README.md e campaign.md)
```

## Estrutura Gerada

```
campaign-rpg/drafts/a-maldicao-de-thornwick/
  README.md                          ← ATUALIZADO (storytelling aprovado + links de capítulos)
  campaign.md                        ← ATUALIZADO (dados finais + prompt de capa)
  story.md                           ← existente (storytelling completo)
  REVIEW.md                          ← este arquivo
  introducao/
    README.md                        ← existente
    sobre.md                         ← existente
    visao-geral.md                   ← existente
    historico.md                     ← existente
    interpretacao.md                 ← existente
  capitulos/
    01-as-noites-que-devoram/
      index.md                       ← CRIADO
      01-a-vila-que-respira-com-medo.md  ← CRIADO
      02-o-que-os-mortos-deixaram.md     ← CRIADO
      03-a-primeira-noite.md             ← CRIADO
    02-a-fonte-da-maldicao/
      index.md                       ← CRIADO
      01-o-cemiterio-que-respira.md  ← CRIADO
      02-os-corredores-de-aldric.md  ← CRIADO
      03-o-coracao-da-maldicao.md    ← CRIADO
```

## Capítulos e Cenas

### Capítulo 1 — As Noites que Devoram (papel: discovery, nível 1)

| Cena | Local | Criaturas | XP/PC | Dificuldade |
|---|---|---|---|---|
| 1.1 — A Vila que Respira com Medo | village (praça central) | nenhuma | 0 | — |
| 1.2 — O Que os Mortos Deixaram | custom (casa do curandeiro) | nenhuma | 0 | — |
| 1.3 — A Primeira Noite | village noturna | Skeleton ×1/PC + Zombie ×1/PC | 100 | moderate |

### Capítulo 2 — A Fonte da Maldição (papel: climax, nível 1→2)

| Cena | Local | Criaturas | XP/PC | Dificuldade |
|---|---|---|---|---|
| 2.1 — O Cemitério que Respira | custom (cemitério) | Skeleton ×1/PC + Zombie ×1/PC | 100 | moderate |
| 2.2 — Os Corredores de Aldric | dungeon (cripta) | Ghost (boss) — se não apaziguado | 1100 (combate) ou 1100 (roleplay) | high |
| 2.3 — O Coração da Maldição | dungeon (câmara ritual) | Wraith (boss) — SÓ se Ghost não apaziguado | 1800 | high |

## Transições

- **1.1 → 1.2**: Marta e/ou Padre Henwick mencionam a casa abandonada de Aldric perto do cemitério.
- **1.2 → 1.3**: O sol cai enquanto os heróis ainda estão na área. A noite é inevitável.
- **1.3 → Cap.2**: Na manhã após a primeira noite, aldeão relata que "o chão do cemitério se mexe mesmo de dia, desde que Harwick foi enterrado."
- **2.1 → 2.2**: Passagem secreta entre as raízes da oliveira leva à cripta de Aldric.
- **2.2 → 2.3**: Ghost apaziguado = câmara final silenciosa (ritual sem combate). Ghost não apaziguado = foge para câmara final e se transforma em Wraith.

## Validação SRD [SRD 5.2.1 — CC-BY-4.0]

- **Nível do Grupo**: 1
- **PCs**: 1–4
- **Orçamentos por PC (Nível 1)**: Low (25 XP) | Moderate (50 XP) | High (75 XP)

### Análise de Cenas e Encontros

| Cena | XP/PC | Avaliação |
|---|---|---|
| 1.3 — A Primeira Noite | 100 XP | moderate (2× moderate, acumulado) |
| 2.1 — O Cemitério que Respira | 100 XP | moderate (2× moderate, acumulado) |
| 2.2 — Os Corredores de Aldric | 1100 XP | high (boss) |
| 2.3 — O Coração da Maldição | 1800 XP | high (boss, condicional) |

## Validação de Progressão (Spec A07)

Fórmula: `xp_threshold(N) = xp_threshold(N-1) + floor(300 * (N-1)^1.5)`

- `xp_threshold(2) = 0 + floor(300 * 1^1.5) = 300 XP`

### Caminho pacífico (Ghost apaziguado, sem Wraith):

- Cena 1.3: 100 XP/PC
- Cena 2.1: 100 XP/PC
- Cena 2.2 (roleplay): 1100 XP/PC
- **Total**: ~1300 XP/PC

**Cobre Level 2 (300 XP exigido): SIM — com ampla margem.**

### Caminho por combate (Ghost não apaziguado, Wraith ativo):

- Cena 1.3: 100 XP/PC
- Cena 2.1: 100 XP/PC
- Cena 2.2 (combate Ghost): 1100 XP/PC
- Cena 2.3 (combate Wraith): 1800 XP/PC
- **Total**: ~3100 XP/PC

**Cobre Level 2 (300 XP exigido): SIM — cobre com excesso (pode cobrir até Level 3 em alguns grupos).**

**Nota**: O Mestre pode ajustar o XP do caminho de combate para evitar nível duplo se preferir. O caminho pacífico oferece progressão mais equilibrada para uma sessão de ~2 horas.

## NPCs Principais

| NPC | Papel | Localização |
|---|---|---|
| Marta | Anciã informante — sabe do exílio de Aldric | Praça Central (Cena 1.1) |
| Padre Henwick | Aliado clerical — refúgio e moral | Igreja / Cemitério (Cenas 1.1, 1.3, 2.1) |
| Aldric (Ghost/Wraith) | Antagonista / vítima — pode ser apaziguado | Cripta (Cena 2.2) / Câmara (Cena 2.3) |

## Objetos-Chave

| Objeto | Localização | Relevância |
|---|---|---|
| Diário de Aldric | Casa do curandeiro (Cena 1.2) | Contexto e background — humaniza Aldric |
| Pergaminho de memória | Casa do curandeiro (Cena 1.2) | Item-chave para ritual de apaziguamento em 2.2 |
| Segundo pergaminho (cópia) | Ossos de Aldric (Cena 2.2) | Alternativa ao pergaminho da casa |
| Faca de prata | Baú do celeiro (Cena 1.3) | +1d4 dano vs mortos-vivos (opcional) |

## Encontros Narrativos (fora do orçamento intencional)

> ⚠️ Os encontros abaixo NÃO devem ser calculados como dificuldade normal pelo sistema. São intencionalmente desequilibrados — existem como punição narrativa para heróis que ignoraram todas as pistas de apaziguamento.

| Cena | Criatura | CR | XP/PC | Orçamento High nível 1 | Classificação |
|---|---|---|---|---|---|
| 2.2 | Ghost (Aldric) | 4 | 1100 | 75 | `narrative_only` |
| 2.3 | Wraith | 5 | 1800 | 75 | `narrative_only` |

**Como persistir no banco:** ao fazer `POST /scene_creatures` para esses encontros, usar um campo que sinalize ao UI que são encontros narrativos — sugestão: `encounter_type: narrative_only` ou `is_narrative: true`. O UI não deve exibir dificuldade nem balanceamento para eles.

**Resolução alternativa (sem combate):** Ghost apaziguado = XP de roleplay equivalente (1100 XP/PC). Wraith não aparece se Ghost foi apaziguado. O caminho pacífico é o caminho esperado para grupo nível 1.

## Pendente / Próximos Passos

- [ ] Gravar no banco de dados (aguarda aprovação explícita do Mestre: "pode gravar no banco")
- [ ] Definir campo `encounter_type` ou `is_narrative` na API de `scene_creatures` antes de persistir cenas 2.2 e 2.3
- [ ] Gerar imagem de capa com prompt incluído em README.md e campaign.md
- [ ] Revisar/atualizar pasta `introducao/` com novos dados finais (nome, visibilidade, etc.)
