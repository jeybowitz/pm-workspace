---
name: user-guide
description: Write a short, illustrated how-to for one <product> feature (Admin panel, staff application or Customer application) for the people who will use it - platform admins, organizers, cashiers - as an interactive HTML artifact and a Confluence help page, with real screenshots taken in the browser. Use this skill whenever the user wants a feature explained to its users rather than specified for developers - "napisz instrukcję dla użytkowników", "zrób helper do <TICKET_KEY>", "instrukcja ficzera", "how-to dla adminów", "write a user guide for this feature", "help page for organizers", "onboarding doc for the new screen" - even when they only name a Jira key and say "dla userów". Not for release notes (release-note), design handoffs or specs (jira, spec-interview).
argument-hint: <jira key or feature name> [audience] [environment URL]
---

Write a user guide for one feature: a 1-2 minute read, one screenshot per step, in the language of the UI the reader sees. Two deliverables: an interactive HTML artifact (step rail, one step at a time) and a Confluence page in the help folder. The guide is for the person clicking through the screen, so it says what to click and what happens, and nothing about tickets, sprints or who built it.

## Input

- A Jira key (epic or story) or a feature name. An epic is the usual input; its child stories hold the labels and behaviours.
- Audience: platform admin, organizer, cashier or buyer. Ask only if the feature serves more than one and the user did not say.
- Environment where the feature is deployed, e.g. `https://<admin-environment-host>`. Screenshots come from there, never from Figma unless the user asks.
- Language of the guide. Default English, with the panel switched to English for the screenshots. The guide language and the screenshot language must match, because the labels quoted in the text are the ones the reader looks for on screen.

## Process

### 1. Gather the facts from Jira

Fetch the epic and every child (`parent = <KEY>`), descriptions in markdown. From them pull: the navigation path (menu, page, tab), the exact UI labels, what each control does, confirmations and error messages, and what stays out of scope. On Fable this is a subagent's job (one Sonnet agent, brief in `references/briefs.md`); on Opus or Sonnet do it directly.

Write down only what a ticket states. Where tickets disagree or are silent, the guide says "to be confirmed" and the chat reply names the gap. Every fact in the guide must come from a ticket or from the screen you saw, because a plausible sentence about a button that does not exist sends a real admin looking for it.

### 2. Take the screenshots

Use the Chrome extension (claude-in-chrome) on the user's logged-in session; on Fable delegate to one Opus agent with the brief in `references/briefs.md`. Rules the agent follows:

- Open the environment in a new tab. If the extension answers "This site is blocked by your organization's policy", stop and report: that block is set by the admin of the Claude workspace, not by the user's own approved-sites list, so only that admin can lift it. Ask the user to request it and continue with the text in the meantime.
- Pick a test organizer, event or channel (name containing test, demo, QA). Never save, delete or send anything; open editors and dialogs, then cancel. Never type into credential fields.
- Desktop width around 1440. One PNG per step, named `01-slug.png`, saved under the session scratchpad in `<key>-shots/`.
- Record the exact labels and the navigation path as shown, because the text in step 3 quotes them.

Screenshots can wait: write the text first with a marked placeholder per step, publish, and fill the images in when they arrive. The user often tests the text before the browser is unblocked.

### 3. Write the text

Read `Process/Writing Style.md` in the vault first. On top of it:

- Opening: one or two sentences on what the feature lets the reader do. No background, no "why we built it".
- Steps: numbered, one screen each. A step has the path (Organizer > Configuration > Email templates > Settings), one or two sentences saying what to click and what happens, the screenshot, and optionally one "what if" question with a two-sentence answer (undo, mistake, edge case the reader will hit).
- Labels in quotes exactly as the UI shows them, bold in HTML. Translate from the ticket only until the real screen is seen, then replace with what is on screen.
- Good to know: at most five one-sentence facts the reader needs after the steps (what is locked when, what does not sync, what migrated users already have).
- Cut: ticket keys, names, dates, who confirmed what, what is still in development, Jira status. The reader cannot act on any of it. "To be confirmed" is the only admission of a gap.
- Length: the whole read under 400 words. If the feature needs more, it is two guides.

Save the text as `_Inbox/User guide - <feature>.md` in the vault, so the source survives the session.

### 4. Build the HTML artifact

Load the `artifact-design` skill, then copy `assets/guide-template.html` and fill the `GUIDE` object at the bottom: title, lede, steps (title, path, body sentences, screenshot file and caption, optional tip), facts. The page renders the rail, the progress bar, the keyboard navigation and the placeholders itself, so nothing in the markup needs editing. Publish with the Artifact tool, passing the PNGs as `files` under `shots/`. A step whose `shot.src` is empty shows a "pending" placeholder, so publish before the screenshots exist and republish when they come.

The artifact is private until the user shares it. Say so when handing over the link.

### 5. Create the Confluence page

Read `references/confluence-page.md`. The page goes into the help folder named there unless the user gives another parent. Confluence through MCP takes the page body but not image attachments, so before creating the page settle with the user how the images get in: they attach the PNGs by hand to the page you created (placeholders in the body tell them where), or they give an Atlassian API token and you upload. Creating a page is a publish outside the vault, so show the text and ask once before the call.

## Output in chat

One sentence per deliverable with its link, then the list of gaps found in the tickets as bullets, each one sentence. No restating the guide.
