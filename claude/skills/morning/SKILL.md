---
name: morning
description: Generate the morning briefing for the Product Manager - roll Todo.md over to today, then combine weekly outcomes, personal tasks, Jira movement and today's calendar into one prioritised view. Use this skill whenever the user wants their day laid out - "zrób briefing", "briefing na dziś", "co mam dziś", "co dziś robię", "morning briefing", "what is on today". Note that it writes to the vault: it archives the previous day into Todo Archive.md and carries unfinished tasks forward in Todo.md. Because of those writes, a bare greeting is not enough to run it - the user has to actually ask for the briefing or for their day.
---

Generate a morning briefing for a Product Manager owning the <product> product.

Vault root: the session's primary working directory. Every vault path in this document is relative to it.

## Step 0 - roll Todo.md over to today (do this first, before building the briefing)

`Todo.md` must always end with a day header for **today**. Check the last `## YYYY-MM-DD (dzień tygodnia)` header in `Todo.md`:

- **If it's already today's date:** skip this step.
- **If it's an earlier date (the normal case - one call per day):**
  1. Move **that one day's** entire task table as-is (full text, unmodified) into `Todo Archive.md`, appended at the end under its own `## YYYY-MM-DD (dzień tygodnia)` header, matching the existing archive table format (`| # | Zadanie | Effort | Status | Notatka |`).
  2. From that day's table only, collect every task with status NOT STARTED / IN PROGRESS / BLOCKED / WAITING / MOVED / PARTIAL / draft-not-sent - i.e. yesterday's tasks that were not finished (anything that isn't DONE/DROPPED/RESOLVED).
  3. Create a fresh `## <today> (dzień tygodnia)` section in `Todo.md` with those carried-forward unfinished tasks, renumbered, each row trimmed to its **current/latest status only** - not the full historical narration (that now lives safely in the archive entry from step 1).
  4. DONE/DROPPED/RESOLVED tasks from the old day do not get carried forward - they stay only in the archive.
- **If more than one day has passed** (e.g. the briefing wasn't run for a day, or the vault wasn't touched) - repeat the same move for each intervening day header found, oldest first, carrying only the still-unfinished tasks forward each time, before creating today's section.
- **Blocked/waiting, Future, PS Board sections are untouched by this step** - they aren't day-dated, they persist on their own and don't get archived or rewritten here.

This keeps `Todo.md` at exactly one live day-section plus Blocked/Future/PS Board, and keeps `Todo Archive.md` as the day-by-day historical log.

Create a fresh day section, carry unfinished tasks forward, then archive the old day. This keeps active work visible.

## Sources

Read in parallel:
1. `Weekly Plan.md` in vault root - current week's theme, outcomes, commitments, waiting on
2. `Todo.md` in vault root - personal daily tasks
3. `_Inbox/` in vault - list any unprocessed files
4. `Meetings/Raw/` in vault - flag files added or edited in last 24h
5. Jira (via Atlassian MCP) - query project <JIRA_PROJECT> for tickets where:
   - `assignee = currentUser()` updated in last 24h, OR
   - `assignee = currentUser()` with status In Progress / In Review / In Test / Ready to Test
6. Microsoft 365 calendar (via MCP) - fetch today's meetings (full day range)
7. Slack and Microsoft Teams (via MCP) - the user's messages from the last 24h: mentions, DMs, threads he wrote in, Teams chats updated since yesterday morning. Read-only, never send or react.

## Rules for interpreting sources

**Three task sources, treated differently:**
- Weekly outcomes (`Weekly Plan.md`) = the 3-5 things that MUST be done this week. Top of the briefing.
- Personal todo (`Todo.md`) = personal, daily, short-term. Filter through outcomes - flag tasks that don't contribute to any outcome so the user can drop or keep.
- <JIRA_PROJECT> board (Jira) = long-term team tasks, no daily deadlines. Mention only if a ticket assigned to the user changed status, is blocked, needs a PM decision, or is in their verification queue (In Test / Ready to Test).

**Jira scope (strict):**
- Only tickets assigned to the user are their work. Unassigned or assigned to others - not theirs.
- Do NOT suggest assigning devs to tickets. Devs self-organize from Ready for Work.
- Status "Ready for Work" ≠ PM action. It means dev can pick it up.
- Backlog tickets for future sprints - not today's topic.

**Effort scale:** S ≤ 1h, M 1-4h, L 4-8h. Warn if today's effort exceeds ~6h focus time.

**Calendar rules:** Show only real meetings - skip "Focus time", "Blocked", "OOO" and similar self-set blockers in the meetings list (Focus time is still read, for placing PM tasks - see Time of day). Skip <recurring meetings the user is invited to but does not attend> too , so it neither appears in the list nor counts against focus time. Convert UTC to CET (UTC+2 summer, UTC+1 winter).

**Time of day:** schedule work using the owner's configured preferences and actual calendar availability. Do not infer attention patterns or personal traits. Mark conflicts and insufficient focus time explicitly.

**Slack and Teams :** report only messages that put something on the user's plate or move something that is already there: a question or request addressed to him that needs his reply or action; a stakeholder's answer to an item on the Weekly Plan waiting-on list or an open point inside a Todo.md task; a decision, date or fact that changes an existing task (go-live set, scope changed, meeting moved). Test for each item: would a task for him appear or change because of it - if not, cut it. Out, even when interesting: platform or team facts nobody asked him about, deployment and staging logistics, process notices, volunteers already turned into calendar entries, threads he has already answered, social chatter, bot and Jira/Confluence notifications. Each item names who wrote it, where, what it says (quote the key phrase), which task or waiting-on item it touches, what it asks of him (reply, decision, update), with a link. Keep it to a handful of lines; three good items beat ten. Nothing is written to the vault or Todo.md from this step: propose where it would go and let the user pick - the ingest rule and the "never add a task without asking" rule both apply.

**Out of scope:** Do not include competitor monitoring content. That's a separate workflow (`/competitor-*` skills).

**Exception - first Monday of month reminder:** If today's date is between 1 and 7 of the month AND today is a Monday, append a one-line reminder at the very bottom of the briefing (after "Blokery / decyzje"). Format:

```
**Pierwszy poniedziałek miesiąca** - przejrzyj `Reference/Competitors/_index.md` (sekcja "Monthly cadence") i odśwież najnowszy plik `_landscape-*` w `Reference/Competitors/`.
```

Do not pull any competitor content into the briefing itself. The reminder is a pointer, not a digest.

## Output format (chat, Polish)

```
## Dzień dobry - [YYYY-MM-DD]

**Tydzień: [date range] - [theme]**

**Outcomes na ten tydzień**
- [ ] outcome 1 - krótki status (na track / ślimaczy się / blocked by X / done)
- [x] outcome 2 - done
- ...

**Na dziś** - a markdown table, not bullets. The point of the table is comparison across rows: the reader scans the Outcome column to spot tasks that push nothing, and the Effort column to see where the day's hours concentrate. Bullets hide both, which is why this section kept getting rewritten as a table by hand. Overdue first, potem today. Outcome column: which weekly outcome the task pushes, or "boczne" if none (then suggest drop in Uwagi). Effort S/M/L.

| # | Zadanie | Outcome | Effort | Pora | Uwagi |
|---|---------|---------|--------|------|-------|
| 1 | task A | outcome 1 | M | PM | |
| 2 | task B | boczne | S | AM | nie pcha żadnego outcome, drop? |

Razem: ~Xh focus. [Warn jeśli > 6h.] Rano: X zadań, popołudnie: Y zadań. [Warn jeśli po południu jest więcej niż jedno zadanie L lub więcej niż 3h łącznie.]

**Spotkania dziś** (z kalendarza - bez "Focus time" i podobnych blokerów; godziny CET)
- HH:MM-HH:MM Nazwa spotkania [jeśli Ty organizator: *(organizator)*]
- ...
(Jeśli brak spotkań: "Brak.")

**Inbox do ogarnięcia**
- file 1
- ...

**Świeże notatki** (Meetings/Raw/ z ostatnich 24h - tylko jeśli wymagają follow-upu)
- file - co z tym zrobić
- ...

**<JIRA_PROJECT> board** (tylko twoje tickety - zmiana statusu / blokery / czekają na twoją weryfikację)
- <JIRA_PROJECT>-XXX status - co dalej
- ...
(Jeśli nic istotnego: "Bez zmian.")

**Blokery / decyzje** (waiting-on list z Weekly Plan + cokolwiek innego stuck - kogo dziś gonić)
- ...

**Slack i Teams** (ostatnie 24h - tylko to, co wiąże się z zadaniem dla Ciebie: pytanie do Ciebie, odpowiedź na coś, na co czekasz, zmiana w istniejącym zadaniu; każda pozycja z tym, czego od Ciebie wymaga, i propozycją, gdzie to zapisać)
- [kanał/czat] kto, co powiedział - czego dotyczy - zapisać w: X
- ...
(Jeśli nic: "Nic wartego zapisania.")

[Only if today is first Monday of month:]
**Pierwszy poniedziałek miesiąca** - przejrzyj `Reference/Competitors/_index.md` (sekcja "Monthly cadence") i odśwież najnowszy plik `_landscape-*` w `Reference/Competitors/`.
```

Keep it short. Readable in under 2 minutes. No fluff, no marketing voice. Use `-` not `—`.

## Do not save the briefing

The briefing itself is a chat-only artifact. Do NOT write it to `Daily/` or any other file - `Todo.md` already tracks per-day tasks with DONE/NOT STARTED/MOVED status, so a separate daily snapshot duplicates it. The only files this skill writes to are `Todo.md` and `Todo Archive.md`, and only via the Step 0 day-rollover described above.

If the user adds new tasks or marks items DONE in chat, update `Todo.md` directly in today's section.

## Never add a new task without asking

The day-rollover in Step 0 carries forward tasks that already exist - that is not adding, and it needs no permission. Writing a task the user never asked for is different and is not allowed. If the briefing surfaces something that looks like work (a ticket that needs a decision, a stale document, an inbox file), name it in the briefing and let him decide; do not put it in the table as a new row on your own.

See the task-selection rule in the wrap-up skill.
