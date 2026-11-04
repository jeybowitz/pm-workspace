---
name: wrap-up
description: Review the current conversation and update Todo.md accordingly - mark finished items DONE, update statuses, drop what is no longer relevant, and propose any new action items in chat for the user to pick from. Use this skill whenever the user wants the todo list brought in line with what just happened - "zrob wrap up", "zaktualizuj todo", "wrap up this session", "update my task list". Conservative by design; it never writes a new task without asking.
model: claude-sonnet-5
---


Review this conversation and update the todo list accordingly.

The todo list lives in the vault: `Todo.md` in the vault root, which is the session's primary working directory. The effort scale and the daily budget rule are at the top of that file.

Steps:
1. Read the current `Todo.md`.
2. Review what was done in this conversation - completed tasks, decisions made, new action items surfaced.
3. Update `Todo.md`:
   - Mark completed items as DONE (with date).
   - Update the status or the note on an existing row where the session moved it.
   - Remove or reprioritize items that are no longer relevant.
   - Keep the existing format and structure (table per day, Effort column, Notatka column).
4. Propose new tasks in chat - do not write them (see the rule below).
5. Briefly summarize what changed (2-3 bullet points max).

## Never add a new task without asking

A new row in `Todo.md` is the user's decision, not yours. Tasks that surfaced during the session get **proposed in chat** as a short numbered list, one sentence each, and only the ones the user picks get written. Tasks the user dictated himself go in directly, no question needed. Editing an existing row - status, date, note - never needs asking; only new rows do.

Every proposed task costs the owner attention. Add only tasks the owner chooses.

Two tests before something is even worth proposing:

- **Does it change his work, a stakeholder's expectation, or the development?** If nothing outside the vault breaks when it never gets done, it is not a task. A finding belongs in the document it concerns, mentioned once in chat. "Decide what to do with the old Claude memory directory from the previous account name" is the reference example of a non-task: real, tidy, and with no effect on his work.
- **Did he take it on, or did you infer it?** Follow-ups pulled out of a log, a workshop note or a transcript that he never committed to are yours, not his. "RO ingest - follow-ups from the workshop" is the reference example.

Work on the collaboration itself - skills, memory, templates, vault structure - does belong on the list when he is the one who has to do it. Do not route it to a side file; a separate tooling backlog rots and he has said so.
