# Jira ticket style rules

Reusable ticket-writing rules. They override the vault templates on conflict.

Refer to rules by name, not by number - the list grows and numbers shift.

**General writing rules live in `Process/Writing Style.md` in the vault, section "Rules for every artifact", and apply to tickets too.** They are not repeated here: dashes (`-`, never `—`), platform vocabulary instead of invented labels, no vague verbs, never invent a value the source did not give, write standalone with no rewrite history, no local vault paths in anything that leaves the vault. Read that section as part of Step 2.

## 1. Business not technical

Context, Story, As is, To be and AC describe what the user wants and what the system does. No class names, DB columns, file paths, DTO mentions, method signatures.

API field names can appear in acceptance criteria when they remove ambiguity and are verified against the configured API documentation. Never carry API behavior over from examples.

## 2. Mid-senior dev baseline

Skip what a dev already knows from the code.

- No mechanism explanations ("the platform resolves language from..."). State the gap or the change, not the existing plumbing.
- No "where data comes from" enumerations.
- No general-rule-with-example restatements. If the bullet says "every email reads the captured language", don't follow with "an admin in English issuing a refund on a Polish purchase gets a Polish refund email".
- No safety-net AC bullets ("value is never empty when the source always provides one") that any sensible implementation honours anyway.
- No invented requirements (logging, ops alerts, monitoring extras) the source PRD did not ask for.
- No code-derived facts the dev reads straight from the code - this applies to the **As is** line too, not just AC. A sentence that narrates what the code obviously does is noise even when it carries a code anchor. Drop the narration; if the anchor is genuinely needed (a real "as is" / legacy claim), give it bare. Example to cut: "Section is captured on the ticket at sale, so a later move does not change sold tickets" - a mid dev knows the section is snapshotted on the ticket.

Sanity check each line: would a mid-senior dev say "yes, obviously"? Cut.

## 3. Lean

- No metadata header block in stories (no Epic/Jira/Status/Priority/Type lines - those are Jira fields).
- Story: exactly 1 sentence. Omit the section entirely for backend-only, reporting, email template changes, infrastructure tasks.
- No Definition of Done section . The team DoD is a standing team standard, the same on every ticket, so it is not repeated in the description. Anything ticket-specific someone wants to put there is an acceptance criterion.
- AC bullets: only what could be implemented wrong, defines scope, or is a non-obvious constraint. Not a complete specification.
- No explanatory parentheticals in AC bullets - state the rule, not the reasoning.
- Out-of-scope: inline as labelled AC bullets (`Out of scope: ...`), never a separate section.
- No sub-bullets unless the variant changes behaviour meaningfully.
- No edge cases for "feature not used = nothing changes" - dev assumes that.

## 4. Don't invent requirements

Every bullet must trace back to the source PRD or to a real product/business decision. Logging, observability, "ops visibility" bullets are especially tempting and especially out of scope unless someone explicitly asked for them.

When a section or field has no source and you are not sure what belongs there, write `TBD`. A plausible sentence reads as a decision and someone builds to it .

## 5. Section headers and group labels

- Section headers: `###` headings (Story, Context, As is, To be, Acceptance criteria). Stories and epics use the same level. Use the same heading level consistently.
- Group labels inside AC: `**Bold:**` (bold + colon). Examples: `**Checkbox reservation last step:**`, `**Search:**`, `**Chart rendering:**`.
- Bullets: `-` (works in Jira and matches vault style; `*` also acceptable).

## 6. Polish UI copy

Inline in AC bullets as a sub-bullet, never blockquoted. Verbatim Polish, no translation.

Example:
```
- Płatność nieudana - operator widzi modal z komunikatem i opcją ponowienia.
    * Modal: "Nie udało się wygenerować linku płatności. Spróbuj ponownie."
```

## 7. Permissions

Inline in the relevant AC bullet:

```
- Operator może anulować rezerwację. Permission: `<PERMISSION_KEY>`
```

Group-level permission: state once under the group label.

## 8. Figma, code anchors and where links live

**Links are attached in Jira's web links panel, not written into the description.** Figma frames, Confluence pages and any other external reference go there, on the story and on the epic alike. The description carries no links section.

**Figma**: link the exact frame, e.g. `https://www.figma.com/design/<FILE_KEY>/<file-name>?node-id=<NODE_ID>`. One web link per frame the ticket covers - desktop and mobile are two links.

Never a bare node ID (`<NODE_ID>`, `node <NODE_ID>`). A reader cannot open it, and a dev has to hunt for the frame by hand. Never the file without a `node-id` either - that drops the reader on whatever page was last open.

**No code anchors in "As is"** : the **As is** section describes current behaviour in business terms only - no repo, class, component, file path or file:line. The PM does not need to know where the behaviour lives in the code and the dev finds it faster than a ticket can point. Verification provenance (which code was read, which commit) stays in the vault document's AI Context section, never in the ticket. If current behaviour could not be verified, write TBD and say so - don't hide it.

**Code anchors anywhere else are the exception, not a default** : a file path or class name belongs in the ticket only when the dev cannot act without it (an exact endpoint or config key being changed). Don't list the code you read while researching just because you read it - a dev opens the actual code, not a ticket-shaped table of contents for it, and every path listed is one more thing to go stale the next time that code moves.

**Never write a "none provided" / "N/A" line.** If a normally-expected item genuinely has nothing to show, leave the line out rather than stating its absence - a missing line says nothing happened here; a line that says "none provided" reads as a gap someone forgot to fill.

## 9. AC altitude - verifiable within this story alone

For each AC bullet ask: can QA verify it by testing **this story alone**? If proving it needs another story's backend, or it restates an epic-level objective, or it is an architectural property (e.g. "config-driven, no code change to add a language") - it does not belong in this story. It goes to the story that actually delivers it, or stays at the epic level.

This error comes from treating the PRD as a list of bullets to hand out. The PRD is source material describing the whole feature; derive each story's AC fresh from "what would QA check on this screen / in this flow", do not bulk-copy PRD lines down into a single story.

## 10. No negative specs from our own deliberation

State what to build (the positive spec) and stop. Do not add what NOT to build in order to rule out alternatives that only ever existed in PM discussion and never reached the design - the dev never saw them, so "not X, not Y" is rationale dressed as a requirement.

A negative bullet earns its place only when it prevents a realistic implementation mistake (e.g. "these permissions do not apply to the organizer" when a dev might assume they do). Test: would a dev, building straight from the design, plausibly do the thing you are forbidding? If not, cut it. Example: "Color is set in the assign step" is the full spec; "not per pool and not from the side panel" is rejected-alternative noise.

## 11. No visual design description

The linked design is authoritative for how the screen looks, so describing it in words duplicates it and goes stale the moment the design changes. Leave out badge colors, icon names and placement, toolbar or panel position, column widths, spacing, labels that are readable straight off the frame.

Write AC around what the user can do and what the system must do. A visual element earns a mention only when it carries a rule that is invisible in the frame - which of three colors appears under which condition, when an action is disabled, what the sort order is.

Cut: "Blocked seats show a grey badge with a lock icon in the top-right of the seat chip."
Keep: "A seat blocked by another operator cannot be selected; the block owner and the block reason are shown on hover."

**Component type is a legitimate exception.** Naming the component is often the fastest way to fix the behaviour, and it is not always visible in a static frame. Modal versus inline panel decides whether the rest of the screen stays usable. Dropdown versus autocomplete decides whether the list is filtered server-side. Side panel versus separate page decides whether the user keeps their place in the list. Radio group versus multi-select decides how many values can be chosen. Name it when that choice carries the rule; skip it when the frame already settles the question and nothing behavioural hangs on it.

## 12. AC cover only what this ticket changes

Before each AC bullet, ask: does this describe new behaviour this ticket introduces, or something the system already does? Existing behaviour is out of the change's scope - QA cannot tie it to this work, and it reads as if the team is rebuilding something that already ships. This applies when hardening existing behaviour and when a new flow merely opens or reuses an existing feature.

If the existing feature needs to be named so the dev knows the flow reaches it, put it in Context or in the flow prose - not in AC.

## 13. No Decisions or rationale section

Never add a "Decisions", "Rationale", "Why this approach" or "Rejected alternatives" section, and never a "Proposed technical approach" section. A dev wants what to build and how to verify it; the decision history is noise at that moment and it belongs where product reasoning lives - the Discovery doc or the PRD.

The ticket states the resulting behaviour in AC and stops. Same instinct as the no-negative-specs rule: all of it is the PM's deliberation leaking into a dev artifact.

## 14. Plain language

The vault's plain-language test (`Process/Writing Style.md`, "Plain-language test") applies to tickets like any other artifact. Write Context and AC in the words people actually speak - short sentences, everyday words - not the richer register that only reads well on a page.

After drafting, walk each Context paragraph and each AC bullet and rewrite the dense ones. Common tells:

- Two abstract nouns leaning on each other: "the operation identifier links it to the action" over "a background consequence carries the identity of its originating action".
- A roundabout phrase where a plain verb works: "the area behind the most frequent operational disputes" → "this is where most disputes start".
- Fancy verbs for plain acts: "wires X as the logged area" → "makes X the first area we log"; "the cascades an action sets off" → "the follow-on changes an action triggers".
- Jargon shorthand: "translate on open" → "translate when you open it"; "paginated child entries" → "child entries page by page".

Keep every fact, name, number, permission string, field identifier and Figma link exactly. Simplify how it reads, never what it says. This holds when reviewing a ticket too - a dense but correct AC bullet is still a finding.

---

## 15. No checkbox bullets

Acceptance criteria are plain bullets (`- `). Never `- [ ]`: Jira's editor does not turn pasted Markdown checkboxes into action items, so they land as literal brackets the PM removes by hand . The only way to get real tick boxes is to push the description as ADF with `taskList` / `taskItem` nodes through the Atlassian MCP, and that happens only when the PM explicitly asks to create or update the ticket in Jira.

---

## Vertical slice rule (when splitting an epic into stories)

Each story = a vertical slice that a dev can verify standalone by doing something business-meaningful. Not a horizontal layer (backend / migration / UI / email / config).

**Red flags - reject and re-split:**

- "Provider abstraction layer", "data model", "interface definition" as a standalone story - fold into the first ticket that uses it. The abstraction proves itself by being consumed.
- Backend-only story whose acceptance is unobservable until UI sibling ships - bundle the minimum UI touch that makes it observable.
- UI fragments split across multiple stories that share one user flow - merge them.

**Test for each story**: name the concrete business scenario a dev would run to see it working (e.g. "employee cancels a booking → room becomes available"). If no such scenario fits in the story's scope, the split is wrong.

---

## Title patterns

Short (3-8 words), sentence case, no trailing punctuation. English by default.

| Pattern | Format | Example |
|---|---|---|
| Feature + scope | `[Feature] on [level]` | `Booking policy on team level` |
| Context + action | `[Context] - [specific action]` | `Booking page - hide optional images` |
| System + behaviour | `[System/tool] - [what it does]` | `Calendar - synchronizing cancelled bookings` |
| Area + sub-area | `[Area] \| [sub-area]` | `Booking dashboard \| tool panels and modals` |
| Imperative | `[Verb] [object]` | `Implement country switcher component` |
| Integration | `[Product A] x [Product B]` | `Payment Provider X x <product>` |
| Simple noun phrase | `[Feature name]` | `SMS ticket`, `Price category fee types` |

Never start with "As a...", "Story:", or a ticket number. Avoid generic verbs like "Update", "Fix", "Changes to" unless nothing else fits.

---

## Fictional benchmark

See [room-booking tickets](../../../../examples/room-booking/tickets.md). No private tickets are included.
