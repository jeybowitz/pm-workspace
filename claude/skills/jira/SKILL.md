---
name: jira
description: Write, review or tighten a Jira ticket - story, epic, or technical ticket - for the <product> product, from a source PRD in Discovery/ (Status: Spec ready), a chat description for single tickets, or an existing ticket. Use this skill whenever the user wants to create, draft, write or scaffold anything that will land in Jira, and equally whenever they want an existing ticket or draft judged, cut down or tightened - "napisz ticket / epic / story", "utwórz task", "stwórz story", "draft jira ticket", "dopisz ticket techniczny", "sprawdź ten ticket", "dociśnij ten draft", "przejrzyj <TICKET_KEY>", or a reference to a Discovery/ doc they want turned into work items. This applies to backend, migration and other Technical Development tickets too - "it is a technical ticket, not a story" is not a reason to skip this skill. It owns the team's ticket style rules, so consult it before writing or assessing any Jira content. Enforces the Spec-ready gate for epics but allows single-ticket shortcuts from chat. Drafts in chat, saves to vault on approval, never pushes to or edits Jira directly.
---

# Jira ticket skill

Draft a Jira ticket - story, epic, or technical ticket - for the <product> product. Output to chat, save to vault on approval, stop. Never push to Jira via MCP.

Everything headed for Jira comes through here, including terse technical tickets that carry no user story. Hand-writing one straight into Jira skips the template, skips these style rules, and skips the vault copy.

Vault root: the session's primary working directory. Every vault path in this document (`Discovery/`, `Jira/`) is relative to it. Structure and rules live in this skill's `references/`, not in the vault.

## Pipeline rules

Discovery (Status: Spec ready) → Jira. Enforced for epics, relaxed for single stories.

| Input | Story | Epic |
|---|---|---|
| File in `Discovery/` with `Status: Spec ready` | OK | OK (best path) |
| File in `Discovery/` below Spec ready | Ask: draft anyway or wait for Spec ready? | REFUSE - propose moving the doc to Spec ready first |
| Chat description only | OK | REFUSE - propose writing a Discovery/ PRD to Spec ready first |
| Existing Jira/ ticket as context | OK (e.g. alt variant of existing) | OK (e.g. follow-up epic) |

If refusing, do not draft. State why and offer the alternative path - which is `/spec-interview` on that document first, then back to `/jira`.

**Technical tickets** (backend work, migration, API preparation, infrastructure - Jira issue type Technical Development) sit outside this gate. They implement a decision that already exists somewhere: a parent story in grooming, a dev request, a chat instruction. A chat description is enough. The gate exists to stop half-resolved product scope reaching the team, and a technical ticket carries no product scope of its own. Two limits: a technical ticket is always a single ticket, never an epic, and if the request actually hides an unresolved product question, treat it as a story and apply the gate.

## Inputs accepted

- `/jira <path>` - explicit path
- `/jira <name>` - glob in Discovery/
- `/jira <chat description>` - free text (single ticket only - a story or a technical ticket, never an epic)
- `/jira` - check conversation context for a recently referenced file or topic; ask if unclear

## Step 1 - Resolve and classify source

Find the source. Classify by its `Status:` field to decide if drafting is allowed (see Pipeline rules table). If the input is chat-only, classify by intent (single story vs epic) - epics need a Discovery/ PRD at Spec ready first.

**Before drafting an epic (or several stories) from a Discovery/ doc, check whether it is already covered in Jira.** A `Status: Spec ready` field only means nobody has updated it since - a document can sit there for months while its content ships piece by piece, and the doc is often the last thing anyone touches. Look for a `Jira epic:` / `Jira:` field in the source first; if there is one, or if the doc names ticket keys anywhere, fetch them (read-only, Atlassian MCP) before drafting anything. If none is named, a quick JQL text search on the doc's title/keywords is worth it whenever the doc's `Updated`/`Date` field is more than a month or two old. If real tickets already cover some or all of the scope, say so instead of drafting duplicates - name what exists and its status, and draft only the part that genuinely has no ticket yet. This check is what a good PM does by habit before writing anything from an older doc; skipping it is how a fresh epic ends up duplicating work that already shipped.

## Step 2 - Read templates and style rules

Always re-read these. They evolve.

- `references/story-structure.md` - story structure and a worked example
- `references/epic-structure.md` - epic structure, plus what an epic always omits
- `references/style-rules.md` - read ALL rules before drafting (don't rely on a remembered count - the list grows)
- `references/readiness-score.md` - the qualitative readiness checklist; load it only in review mode
- `Process/Writing Style.md` in the vault, section "Rules for every artifact" - the writing rules that hold for any artifact, tickets included: dashes, platform vocabulary, no vague verbs, never invent a value, standalone with no rewrite history, no vault paths outward. The style rules deliberately don't repeat them.
- `Process/Writing Style.md` in the vault, "Plain-language test" section - write in the words people actually speak, short sentences, everyday words. It applies to tickets too (see style-rules "Plain language").

The structure files give shape. Style rules give discipline. On conflict, style rules win (they're more recent corrections).

## Step 3 - Detect mode

- **Single story** - one capability, one user flow
- **Epic + child stories** - multi-capability, multi-deliverable. Draft the epic plus a list of child stories using vertical-slice splits (see style-rules).
- **Technical ticket** - work with no user-facing capability of its own: backend change behind an existing flow, data migration, API groundwork, dependency upgrade, cleanup. Shape it as: no Story section, Context in one or two sentences naming the parent ticket or the trigger, As is and To be in a sentence each, AC as the checks a dev can run. Match the terseness of the parent ticket rather than padding it out to story length. All style rules still apply.
- **Both / ambiguous** - ask before drafting

## Step 4 - Classify gaps

Walk through these checks. For each gap, decide where the answer comes from:

1. **Data semantics** - every metric/value/enum the UI shows needs a formula or definition. If the source names a field but leaves its value open (a rate, a limit, a default), that is a PM question - leave it blank in the draft and ask, never fill it with a plausible number
2. **Side effects** - state-changing actions need a cascade list (emails fired, refunds triggered, reservations expired, staff application sessions closed)
3. **Failure modes + Polish copy** - what does the user see when upstream fails / validation breaks
4. **Permissions** - which role or permission string gates the action
5. **Timezone / locale** - which timezone the UI renders in; per-market behaviour
6. **Legacy "as is" references** - any "preserves legacy" claim needs a code anchor on the **As is** line; no naked "as is"
7. **Cross-scope check** - does the rule extend beyond the stated scope

Resolution paths per gap:
- **In the source** - use it
- **Discovery is the source of truth for behaviour and rules.** When a Discovery doc at Spec ready backs the ticket, its text defines what the system does. Read it before reaching for the design. The design flows from Discovery, not the other way round: on a conflict, Discovery wins, and a rule that appears only in the Figma is a designer decision that was never speced - flag it and reconcile it back into Discovery, do not silently transcribe it into the ticket. If a Discovery doc exists but leaves the rule open, that is a PM decision (block), not a thing to settle from the frame.
- **Code lookup needed** - do it as part of drafting, without asking. Research is part of ticket creation, not a follow-up, and a `[DEV]` question left in a draft is a question that could have been answered by reading the code. Check `~/repos/<company>/<specs-repo>/` first, then grep or spawn Explore on `~/repos/<company>/<backend-repo>` (backend) or `<admin-frontend-repo>` (frontend).
- **Figma needed** - if the source doc or conversation has a Figma link, pull it via the Figma MCP without asking. Only ask the user for a link when none is available, and ask for one that opens the exact frame, not the parent frame. Read the design for the flow and the states - which screens exist and how they follow each other - not for the rules, which come from Discovery (see the source-of-truth path above), and not to transcribe how it looks. What the frame shows visually stays in the frame (see the no-visual-design rule); the ticket carries the frame link so the dev sees it first-hand.
- **PM decision needed** - list in chat as a question, BLOCK the draft until answered
- **Tech / grooming** (endpoint shape, service ownership, request/response format) - mark `[dev / grooming]`, do NOT block, do NOT include in the ticket. These resolve in grooming with the team; they are not PM decisions and they never justify holding a draft.

Hard blockers (multiple unresolved PM decisions, incomplete scope) - surface them and STOP. Do not draft a half-baked ticket. A single PM question is asked in chat. More than one: do not ask them one by one - propose running `/spec-interview` on the source first, which resolves them in one interview and writes the answers into the Discovery document, and come back to `/jira` after.

## Step 5 - Draft

Apply all rules from `references/style-rules.md`. Use the structure from `references/story-structure.md` or `references/epic-structure.md`.

Keep code anchors from research in local vault notes, not in the ticket - the only exception is a real "as is" / legacy claim, whose anchor goes on the **As is** line (see the Figma and code anchors rule). Figma frames and Confluence pages are attached as Jira web links, never written into the description.

## Step 5a - Facts list

Before showing the draft, list in chat every fact the draft states as settled: default values, permission names, where a setting or screen sits in the UI, labels and option names, which system does the work (ours or a vendor's), what is in and out of scope. One line per fact, with its source: the Discovery doc, a file and line in the code, Confluence, or the PM by name. A fact with no source goes into the draft as `TBD` - never as the most plausible sentence.

## Step 5b - Plain-words pass

After the draft is written and before it is shown, rewrite it once with the plain-language prompt from `Process/Writing Style.md`: much simpler language, short sentences, everyday words, every fact, name and number kept. Show only the rewritten version. Check it against the Words to avoid table as part of the same pass.

## Step 6 - Output to chat, pause

Print the facts list from Step 5a, then the draft. Below it, list any open questions for the PM (gaps couldn't fill from source / code / Figma). A blocking question stays in chat and holds the draft. A non-blocking question with a named owner may also sit in the epic's Open questions section.

Wait for explicit approval before saving. Approval phrases: "zapisz", "save", "OK", "wygląda dobrze", "zatwierdzam".

Never save without approval.

## Step 7 - Save to vault on approval

Target: `Jira/<epic-slug>/`

- **Epic**: detect naming convention used in existing `Jira/<other-epic>/` folders and follow it. Examples seen: `epic.md`, `00 - Epic.md`, `<Epic Title>.md`. When uncertain, ask.
- **Story under an existing epic**: find the next sequential prefix used in that folder (`01 - `, `02 - `, or `story-01-`, `story-02-`). Match the local convention.
- **Story without an obvious epic**: ask which folder, don't guess.
- **Technical ticket**: if it names a parent ticket, save it in that parent's epic folder with the next sequential prefix - the technical work belongs with the feature it serves, not in a separate technical bucket.
- **Single chat-only ticket without an epic context**: ask where to save - propose `Jira/_loose/` or a topical folder.

Confirm the save path in chat. Stop.

## Reviewing or tightening an existing ticket

The same rules govern judging a ticket, not only writing one, so this skill also covers "sprawdź ten ticket", "dociśnij ten draft", "przejrzyj <TICKET_KEY>", "czy to jest OK do groomingu". Without this, the rules would be invisible in exactly the moment they matter most - someone else's ticket already on the board.

- Fetch the ticket: a Jira key via the Atlassian MCP (read only), a vault path via Read, or take the draft pasted into chat.
- Read Step 2's sources first, then walk the ticket rule by rule.
- Report in chat as concrete cuts and fixes, quoting the offending line and naming the rule it breaks. Not a general impression - a list someone can act on.
- Apply references/readiness-score.md and report each check as supported, missing or not applicable, with a short reason. Surface blockers; do not assign a numeric score or automatic approval.
- Stop there. Never edit the Jira ticket, and never edit a vault draft, without being asked. Present the findings, let the PM decide what to apply.

If the review turns up an unresolved product question rather than a style problem, say so plainly - that is a PM decision, not a wording fix.

## What this skill does NOT do

- **Push to Jira via Atlassian MCP** - never. If the user explicitly asks "utwórz w Jira" after the save, that's a separate request - handle it then.
- **Edit existing Jira tickets** - if the user wants to update an existing ticket after research, present findings in chat first, ask before touching.
- **Suggest assignees, priorities, sprint placement, story points** - those are team-lead / grooming decisions.
- **Draft epics from a Discovery/ doc below Spec ready** - not enough is resolved yet. Propose moving the doc to Spec ready first.
- **Add competitor monitoring context** - separate workflow.
