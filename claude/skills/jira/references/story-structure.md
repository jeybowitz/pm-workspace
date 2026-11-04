# Jira Story Template

Reusable ticket draft structure.

The structure of a Jira story. The writing rules live in `style-rules.md` (next to this file) and in the "Rules for every artifact" section of `Process/Writing Style.md` in the vault, and they win over this file on conflict.

---

## Title format

Same patterns as epics - the table is in `style-rules.md`.
The title says what is being built: 3-8 words, sentence case, no trailing punctuation.
No layer suffix (`- BE`, `- FE`). A story is a vertical slice, so a suffix naming a layer means the split is wrong (see the vertical slice rule in `style-rules.md`).

---

## Structure

Section headings are `###`. Group labels inside acceptance criteria stay bold.

```
### Story

[One sentence: As a [role], I want [action], so that [benefit].
Omit the section entirely for backend-only, reporting, email template and infrastructure
tickets - Context, As is and To be carry those on their own.]

### Context

[Two to four sentences: why this story exists and what problem it solves.
If it is follow-up work: "This extends <JIRA_PROJECT>-XXX: [title]."]

### As is

[How it works today, two or three sentences, business terms only. For a new feature write
"Does not exist yet." No repo, class, component or file path - where the behaviour lives in the
code never goes into this section .]

### To be

[How it works once this story ships, in plain business terms. No screen description,
no implementation. The checkable detail goes to Acceptance criteria.]

### Acceptance criteria

**[Group label:]**
- Observable behaviour a tester can check on this story alone
- Formula or definition for every computed value the screen shows
- Cascade list for a state-changing action: emails sent, refunds triggered, reservations expired, staff application sessions closed, external systems notified
- Failure copy as a sub-bullet, Polish verbatim:
    * Modal: "..."
- Permission inline: Permission: `<PERMISSION_KEY>`
- Out of scope: [what is excluded]

**[Next group:]**
- ...

```

---

## Quality rules

**Story**
- Exactly one sentence, in the As a / I want / so that shape. Two sentences means two stories.
- Leave the section out for work with no user-facing capability of its own, rather than inventing a role for it. This holds for technical tickets.

**Context**
- Why the work exists, not what it builds. The what is in To be and Acceptance criteria.

**As is**
- Current behaviour only. Do not explain plumbing a dev reads off the code, and never say where it lives in the code (no repo, class or path).
- "Does not exist yet." is a complete answer for a new feature. Do not pad it.

**To be**
- The end state in business terms. If a To be line repeats an acceptance criterion word for word, cut one of them.
- No visual design description - the linked design is authoritative for how it looks.

**Acceptance criteria**
- Plain bullets (`- `), never checkbox bullets (`- [ ]`): Jira does not render Markdown checkboxes. Real action items exist only when the ticket is pushed as ADF `taskList` nodes through the Atlassian MCP, which this skill does not do by default.
- Business language, not implementation. "The order is stored without an account", not "a guest flag is written to the database".
- Only what could be implemented wrong, defines scope, or is a non-obvious constraint. Not a complete specification.
- Group labels (`**Bold:**`) when the story covers more than one area. A short story needs none.
- Each line verifiable on this story alone. Anything needing a sibling story's backend belongs to that story or to the epic.
- Out of scope goes in as a labelled bullet, never as its own section.

**No Definition of Done section** . The team DoD is a standing team standard, the same for every ticket, so it is not repeated in the description. Anything ticket-specific someone wants to put there is an acceptance criterion.

**Links belong in Jira's web links panel, not in the description body.** Figma frames (the full URL with its `node-id`), Confluence pages, sibling Jira keys and any other external reference are attached as web links on the story.

---

## What to omit

The "Mid-senior dev baseline" rule in `style-rules.md` applies - a mid-senior dev reads this story alongside the code.

Omit from a story, always:
- **Metadata header block** - no Epic / Jira / Status / Priority / Type lines, those are Jira fields.
- **Decisions, Rationale, Rejected alternatives, Proposed technical approach** - product reasoning lives in the Discovery doc.
- **Backend dependency / Depends on lines** - a story's dependencies are Jira's own epic and link structure, not prose the ticket has to maintain by hand.
- **Local vault paths** ("Source PRD: `Discovery/...`") - the vault is local to the PM and the path is a dead link for the team.
- **"None provided" / "N/A" lines** - if a normally-expected item has nothing to show, leave the line out.

---

## Fictional example

See [the room-booking ticket drafts](../../../../examples/room-booking/tickets.md) for an authored synthetic example.
