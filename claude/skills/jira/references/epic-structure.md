# Jira Epic Template

Reusable ticket draft structure.

The structure of a Jira epic. The writing rules live in `style-rules.md` (next to this file) and in the "Rules for every artifact" section of `Process/Writing Style.md` in the vault, and they win over this file on conflict.

---

## Title format

Same patterns as stories - the table is in `style-rules.md`.
The title says what is delivered, not how. Epics tend toward simple noun phrases or feature + scope:
- `Analytical trackers`
- `Organizer-level tracking management`
- `Room booking`

---

## Structure

Section headings are `###`, the same as the story template.

```
### Outcome

[Two or three sentences. Start with one sentence on the current state and the gap:
what the legacy system or <product> does today, and what is missing.
Then what this epic delivers, for whom, and why it matters. No "how", no scope detail.]

### Success metrics

[A number measured after release, with the baseline when we know it.]

### Scope

Included:
- [Capabilities this epic delivers]

Not included (this phase):
- [What is deliberately left out, so nobody plans it in]

### Done criteria

- [Checkable states that must be true before the epic can be closed]

### Dependencies

Internal: [Which team or person this waits on]
External: [Third party, another product team, or system]
Blocked by: [Jira keys]
Blocks: [Jira keys]

### Risks

- [What could block or delay this, with the effect it would have]

### Open questions

- [Question - owner]
```

---

## Quality rules

**Outcome**
- One goal, one paragraph. Two paragraphs means the epic should be split.
- Name the legacy system (<legacy system A>, <legacy system A>, <legacy system B>) when the epic closes a gap against it.

**Success metrics**
- A number someone reads off a report weeks after release. Never invent a target - leave it blank and ask.

**Scope**
- "Included" is mandatory. "Not included" is optional but keeps the scope from growing during delivery.
- Scope items are capabilities, not tasks.

**Done criteria**
- Each line independently verifiable. Think: what would you check in production to call this done.
- No vague lines like "users are satisfied" or "performance is improved".

**Success metrics and Done criteria never restate each other.** Done criteria say the work is finished, success metrics say it worked.

**Dependencies**
- Cross-system (payment gateway, CMP, bridge page) and external (agency, partner) dependencies go here.
- Blocked by and Blocks carry Jira keys, and the same links are set as real issue links in Jira.

**Risks**
- Product and cross-team risks only. Implementation risks belong in the stories.

**Open questions**
- Only non-blocking questions, each with an owner. Write "None" when there are none.
- A blocking question means the epic is not ready to be written - it goes to the PM in chat and the Spec ready gate holds.

---

## What to omit

The "Mid-senior dev baseline" rule in `style-rules.md` applies to epics as well - assume a mid-senior dev reads the epic alongside the stories.

Omit from an epic, always:
- **Stories list / table** - Jira links child stories to the epic. Don't maintain a story table in the description.
- **Delivery order / sequencing** - developers decide order during grooming.
- **Postponed / out-of-this-epic story lists** - track elsewhere, not in the epic body.
- **Local vault paths** ("Source PRD: `Discovery/...`", "notes in `Research/...`") - the vault is local to the PM; a path is a dead link for the team. Reference only what a dev can open (Figma, Confluence, Jira keys, code).

**Links belong in Jira's web links panel, not in the description body.** Figma frames, Confluence pages and any other external reference are attached as web links on the epic.

---

## Fictional example

See [the room-booking ticket drafts](../../../../examples/room-booking/tickets.md) for an authored synthetic example.
