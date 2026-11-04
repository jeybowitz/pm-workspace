---
name: monthly-planning
description: Draft the monthly Product Planning Prep page for the team, using the two most recent Confluence pages as structural references and verifying epic status directly in Jira. Use this skill whenever the user prepares for monthly planning - "przygotuj monthly planning", "zrob strone na planning", "draft the monthly planning page", "product planning prep". Output lands in _Inbox/ for review, never published to Confluence directly.
---

Draft the monthly Product Planning Prep page for the team. Output goes to `_Inbox/` for the user to review and paste into Confluence.

## Context

- **Team identity - read this first:** take the team name, the Confluence space and the Jira project from the project's `CLAUDE.md` (section "Team and systems"). If it does not name them, ask the user once and reuse the answers for the whole run. Everything below writes `[Team]`, `[Space]` and `[Project]` where those values go.
- **Where it lives:** Confluence space `[Space]`, pages titled `Product Planning Prep - [Team] - [Month] [Year]`.
- **Cadence:** monthly. Page IDs change every month - do NOT rely on hardcoded IDs. Find the two most recent pages by title search in that space and use them as structural references.
- **Roster:** confirm the current PM/PO, EM and Designer against `Stakeholders/Team Structure.md` before filling the header table. Never carry a name over from a previous run without checking.

## Process

### 1. Read both reference pages first

Pull previous month's page and month-2 page via `mcp__claude_ai_Atlassian_Rovo__getConfluencePage`. Note:
- Section structure (header → leadership → stakeholders → reflection → plans → delivery → discovery → last month's comments → delivered epics → progress vs initiatives → planned vs delivered).
- Tone and table format.
- Which epics were marked "Deploy planned for Monday evening" - those need verification (some slip).

### 2. Pull Jira data

Run these in parallel:
- `project = [Project] AND issuetype = Epic ORDER BY status, updated DESC` (max 50, fields: summary, status, priority, updated, duedate) - current epic state.
- `project = [Project] AND issuetype = Epic AND status = Done AND resolved >= "[prev month start]" ORDER BY resolved DESC` - epics that closed in the previous month.
- For each in-flight epic in delivery scope, drill into children: `parent = <epic key> AND (status = "Done" OR status = "Ready for Live") ORDER BY status, updated DESC` - shows actual progress, not memory's claim.

Always verify status from Jira directly. Memory entries (todo_list, weekly_plan) can be stale.

### 3. Read user context

- `Todo.md` (vault root) - active personal tasks and deadlines
- `Weekly Plan.md` (vault root) - current week's outcomes, commitments, waiting-on
- `Roadmap.md` (vault root) - phase sequencing and what Phase 1 covers; the Confluence roadmap page owned by the head of product is the source it points at
- `memory/MEMORY.md` index - check for relevant memories, which now hold feedback on how to work with the PM and Claude's own tooling detail; product and company facts live in the vault, not there

### 4. Propose plan + ask 1-3 specific questions

Before writing the full draft, summarize in one message:
- What's slipping from previous month (with current % from Jira, not memory)
- What's new for this month (just-started epics, Ready for work items)
- What discovery items carry over

Ask only what you can't infer:
- Leadership input - any new strategic asks since previous page?
- Stakeholder input - anything new since previous page?
- Confidence calls on slipping items where Jira state is ambiguous.

Don't ask about ceremony date - infer from `Weekly Plan.md` or `Todo.md` deadlines.

### 5. Write the draft to `_Inbox/`

File path: `_Inbox/Product Planning Prep - [Team] - [Month] [Year].md`

Match the section structure from the previous page. Use markdown tables (paste cleanly into Confluence and convert to smart-link on URL paste).

## Section-specific rules

### Header table
| Team | [Team] |
| PM/PO | @[from Stakeholders/Team Structure.md] |
| EM | @[from Stakeholders/Team Structure.md] |
| Designer | @[from Stakeholders/Team Structure.md] |
| Month | MM.YYYY |
| Ceremony date | DD.MM.YYYY |

### Leadership / Stakeholder input
Carry forward from previous page unless user gave fresh input. If a stakeholder request from prev page is now being delivered (e.g. a named venue request → <TICKET_KEY> in dev), update the wording from "request" to "in delivery".

### PM/Team reflection
Concrete bullets. What changed since the previous page: deployments, hires, trips, scope decisions, status of cross-team friction. Skip vague platitudes.

### Comments on plans (PM / EM / Design)
PM section: written by you. EM and Design sections: leave as `_To be filled by EM._` / `_To be filled by Designer._` - they write their own. Carry-over notes for the Design section are OK if they were genuinely open from the previous page.

### Proposed initiatives for Delivery (table)
Columns: Deliverable / Epic | Description & Why it Matters | Impact on <company> results (estimated) | Confidence | Jira link | Owner | Dependencies.

**Impact column - critical:** Outcome-focused, not feature description. Bad: "Admins can manage the full event lifecycle, faster operational work." Good: "First market-X MVP-gating feature in active delivery - blocks market-X migration scope until shipped."

Outcome lenses to use: GAP closure vs other markets, retention of specific named organizer, conversion lever, migration gating, ops cost reduction, CS load reduction, regulatory/financial risk, commercial-negotiation argument.

Confidence: High / Medium / Low - based on Jira state, not optimism. If 80% of sub-tasks are Ready for Live, confidence is High.

### Proposed initiatives for Discovery (table)
Items that need analysis / spec / decision before they can move into Delivery. If something is already Ready for work in Jira, it has left Discovery - move to Delivery or drop.

Watch for redundancy: if cross-country fees analysis covers the market-X MVP fee scope, do not have a separate row for "Market X MVP - Fee management spec". One row, mention scope coverage in description.

### Delivered Epics (retro of previous month)
**Hard rule: do not repeat epics that already appeared in the previous month's Delivered Epics table.** If an epic was listed there with caveat "Deploy planned for Monday evening", check Jira: if now actually Done, list it in this page with header note "Confirms epics flagged as 'Deploy planned for Monday evening' in the [prev month] page - now in production." If it's still WIP, list it as a slip with status `**No - slipped**`.

Only genuinely new closures (epics resolved after the previous page was published) belong here as standalone wins.

### Progress Against Initiatives (table)
Track higher-level initiatives (IN-* in Jira). Current month progress, status, next month focus, risks.

### Planned vs Delivered (prev month)
Per-epic % completion from the prev month's plan. Use Jira sub-task counts (Done + Ready for Live / total) for the %.

## Style rules

- Check the "Words to avoid" table in `Process/Writing Style.md` in the vault (e.g. don't use "persistence" - use "storing/saving"). Re-read it each run - the table grows.
- `-` not `—` (vault style).
- English for vault and Confluence content; Polish in conversation with user.
- No marketing voice. Factual.
- Names: first letter of surname + dot in vault context (e.g. PM, Designer). Full mentions OK in Confluence header tables when they map to @mentions.
- Don't repeat content across sections. Each section earns its place.

## After the draft is in `_Inbox/`

Tell the user:
- Where the file is.
- 3-5 specific things to review (e.g. "Delivered Epics is thin - only <JIRA_PROJECT>-X this month, confirm if that's right", "Confidence on Y - I set High based on N Ready-for-Live tickets, sanity check").
- Items left blank for them to decide (EM/Designer comments, anything genuinely uncertain).

Don't publish to Confluence. User pastes manually after final review.
