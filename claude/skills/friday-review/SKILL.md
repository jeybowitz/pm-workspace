---
name: friday-review
description: Run the weekly review for the Product Manager - close the week that just ended and open the next one. Use this skill whenever the user wants to wrap up a week or set up the coming one - "zróbmy review tygodnia", "zamknij tydzień", "podsumujmy tydzień", "zaplanuj nowy tydzień", "friday review", "close the week and plan the next one". Typically run Thursday or Friday, equally valid on the following Monday. Note that it rewrites the vault: both Weekly Plan.md and Todo.md are updated, and closed weeks are appended to Todo Archive.md.
---

Run a weekly review for a Product Manager owning the <product> product. It runs either late in the week or at the start of the following one, and the work is the same either way: close one week, open the next.

## Which week is being closed

Settle this before touching any file, because the answer depends on the day the skill runs:

- **Thursday through Sunday** - the week being closed is the current one (this week's Monday through Sunday). The new week starts on the upcoming Monday.
- **Monday through Wednesday** - the week being closed is the one that just ended (last Monday through Sunday). The new week starts on the Monday of the current week.

Get this backwards and the wrong week gets archived, which is tedious to undo by hand. So state both date ranges explicitly in your first message to the user and let them correct you before anything is written.

## Files

All in the vault root, which is the session's primary working directory:

- `Weekly Plan.md` - read, then rewritten: the closed week is summarised into its history section and the current-week section is replaced with the new plan.
- `Todo.md` - read, then rewritten: unfinished tasks carried forward, closed weeks moved out.
- `Todo Archive.md` - appended: the record of closed weeks.
- `Monthly Plan.md` - read only, for upcoming deadlines when proposing next week's outcomes.

Plan and task content belongs in those files and nowhere else. If an index or memory file merely points at them, treat it as a pointer and leave it alone - writing the plan into the pointer instead of the real file is how a week's plan quietly goes missing.

## Steps

### 1. Read the current weekly plan and fetch calendar data
In parallel:
- Read `Weekly Plan.md`: this week's range, theme, outcomes, commitments, waiting-on list, backlog.
- Fetch calendar via Microsoft 365 MCP: all meetings for the closing week (Mon-Fri). Exclude "Focus time" and similar self-blocked slots. Count total meetings. If the MCP is unavailable, say so and continue without the meeting count.
- If a briefing source is configured, open the latest briefing without turning it into tasks unless asked.

### 2. Close the week (interactive - use AskUserQuestion)
Collect outcome statuses via the AskUserQuestion multiselect UI - do not make the user type each status in chat. AskUserQuestion allows max 4 options per question: with more than 4 outcomes, split into two questions (e.g. "Które z tych outcome'ów są zamknięte?" twice). Do the same for commitments to others and waiting-on items.
For anything marked not done, ask one short follow-up for the blocker (free text is fine there).

Don't assume - ask. Keep it tight.

### 3. Generate the closing summary

Use this structure:

```
## Tydzień zamknięty: [week range]

**Outcomes** (X/Y done)
- ✓ [outcome 1]
- ✗ [outcome 2] - [blocker / reason]

**Spotkania w tygodniu:** X (wysoko/normalnie/mało jak na ten tydzień - 1 zdanie jeśli liczba wpłynęła na delivery)

**Wins** (co wyszło ponad plan)
- ...

**Carry-over do następnego tygodnia**
- [outcome / commitment that didn't close, with reason]

**Lessons** (1-2 obserwacje, jeśli wyłaniają się ze zbioru)
- ...
```

### 4. Plan next week (interactive)
Propose next week's structure based on:
- Carry-over from this week
- Upcoming deadlines from `Todo.md` and `Monthly Plan.md`
- Anything new the user mentions

Suggest 3-5 outcomes, ask user to confirm or adjust (AskUserQuestion works here too). Then ask for theme of the week (1 sentence).

### 5. Update files (vault root)
- In `Weekly Plan.md`: archive closed week to "Historia poprzednich tygodni" (theme + outcome results, 5-10 lines max - not the whole plan), then replace the current week section with the new plan.
- In `Todo.md`: carry forward every task that is NOT STARTED / IN PROGRESS / MOVED / BLOCKED before moving closed weeks to `Todo Archive.md`; only DONE / DROPPED / RESOLVED entries are archived as-is. Archiving without that pass buries open work in a file nobody reads - it has already happened here once and the open tasks had to be dug back out by hand. Then sync the carried-forward tasks with the new weekly outcomes.

### 6. Confirm
Show the user the new plan in the response. Ask if anything else needs adjusting.

## Never add a new task without asking

Carrying an existing unfinished task forward in step 5 needs no permission - it is already his. Writing a task he never asked for does, and the answer is to ask. Anything the review surfaces that looks like new work gets put to him in step 4 as a proposal, ideally through the AskUserQuestion multiselect, and only what he picks gets written into `Todo.md`.

See the task-selection rule in the wrap-up skill.

## Style notes
- Use - not em dash (vault style)
- Polish in conversation; Weekly Plan.md and Todo.md are personal, Polish OK
- Be directive. If user says "skończyłem outcome 2", don't ask what they did - just mark done and move on.
- If user gives a vague answer ("częściowo"), drill down once: "co konkretnie zostało?"
- Don't pad. If a section is empty (e.g. no lessons), skip it.
