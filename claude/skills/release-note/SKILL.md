---
name: release-note
description: Write release page entries for one or more Jira tickets - a ticket key heading followed by a factual two to three sentence description, merging related tickets into a single entry. Use this skill whenever the user builds a release page or changelog - "napisz release note", "opisz to na release page", "write release notes for <TICKET_KEY>", "changelog entry". Factual voice only, no marketing language.
argument-hint: <jira ticket keys>
---

Write a release page entry (ticket key heading + a 2-3 sentence factual description) for one or more Jira tickets. Used when building a Confluence release page where each entry is the ticket key as a heading followed by the description text.

## Input

Argument is one or more Jira ticket keys (e.g. `<TICKET_KEY>`, `<TICKET_KEY> <TICKET_KEY> <TICKET_KEY>`). If multiple tickets are passed and they cover the same change, merge them into one entry. If they are unrelated, produce one entry per ticket.

## Process

1. Fetch each ticket via `mcp__claude_ai_Atlassian_Rovo__getJiraIssue` (cloudId `<ATLASSIAN_SITE>.atlassian.net`, format `markdown`). Read summary, description, issuetype.
2. Decide grouping: tickets share an entry if they describe one user-visible change (e.g. one feature split across stories, or refactor + follow-ups on the same area). Otherwise keep separate.
3. Write the ticket key heading + description in the style below.

## Output format

This is the format the user pastes into Confluence. For each entry:

```
**<TICKET-KEY>**

<2-3 sentence description>
```

The heading is the ticket key (e.g. `**<TICKET_KEY>**`). For merged tickets, join the keys with ` + ` (e.g. `**<TICKET_KEY> + <TICKET_KEY>**`). No separate title line, no `Tytuł`/`Opis` labels. The description is plain text, not a blockquote.

If multiple unrelated tickets, list each entry one after the other separated by a blank line. No preamble, no closing summary.

When saving to the vault, put all entries in one file under `_Inbox/` named `Release notes - <context> <YYYY-MM-DD>.md`.

## Style rules (strict)

- **English** for the description.
- Use `-` for dashes, not `—`.
- No marketing voice. No "we are excited", "now smarter", "enhanced experience". Describe the change, not the value prop.
- No emoji, no exclamation marks.
- Concrete and factual. Name what changed, where, and how a user perceives it.
- Length: description is 2-3 sentences.
- No links inside the description text.

## Fictional description examples

Bug fix: "Fixed a bug where a cancelled room booking still blocked availability. The room is available again after cancellation succeeds."

Feature: "Employees can cancel their own upcoming room bookings. Cancelled bookings remain visible in history."

These examples are synthetic and make no claim about a real product.

## What to skip

- Internal refactor tickets that produce no user-visible change - say so and ask the user whether to include them at all.
- Implementation details (postMessage, JWT, API names, component names).
- Reasons / rationale unless they materially change what the user perceives.
- Lists of acceptance criteria copy-pasted from the ticket.

## When information is thin

If a ticket description is just a screenshot or a one-liner, infer the user-facing change from the summary and the linked context. Do not invent specifics. If you cannot describe the change in one factual sentence, ask the user for the missing piece rather than padding.
