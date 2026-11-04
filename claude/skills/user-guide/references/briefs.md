# Subagent briefs

Two briefs, used when the session runs on Fable (which delegates) or when the work is large enough to hand off. Fill the angle brackets.

## Jira facts (Sonnet)

```
Goal: a compact, verified picture of what <KEY> "<title>" delivers in the UI, for a user guide aimed at <audience>.

Jira: cloud ID <CLOUD_ID>, project <JIRA_PROJECT>. Load via ToolSearch:
select:mcp__claude_ai_Atlassian_Rovo__searchJiraIssuesUsingJql,mcp__claude_ai_Atlassian_Rovo__getJiraIssue

1. JQL `parent = <KEY> ORDER BY key` (fallback `"Epic Link" = <KEY>`). Fetch each child with description in markdown.
2. Per child: key, title, status, and 3-6 lines of user-facing behaviour: where it lives (context, page, tab), fields, toggles, buttons and labels, what happens on save, confirmations, validation and error messages, defaults and scope limits.
3. Mark which stories are Done or Released.
4. Quote UI labels exactly as written in the tickets, in every language given.
5. Flag places where two tickets disagree.

Return in English, under 80 lines. Where a ticket does not say, write "not stated". No speculation.
```

## Screenshots (Opus)

```
Goal: walk through <feature> at <environment URL> as <audience> and produce PNG screenshots of every step plus a precise description of what is on screen, for a user guide.

What the feature is: <3-5 lines from the epic: where it lives, which controls, what it replaces>.

Browser: Chrome extension tools. Load in ONE ToolSearch call:
select:mcp__claude-in-chrome__tabs_context_mcp,mcp__claude-in-chrome__navigate,mcp__claude-in-chrome__computer,mcp__claude-in-chrome__read_page,mcp__claude-in-chrome__tabs_create_mcp,mcp__claude-in-chrome__tabs_close_mcp,mcp__claude-in-chrome__find,mcp__claude-in-chrome__get_page_text,mcp__claude-in-chrome__javascript_tool
Call tabs_context_mcp first, then open a NEW tab. If the site answers "This site is blocked by your organization's policy", stop and report it; do not work around it. If you land on a login page, stop and report; do not guess credentials.

1. Switch the panel language to <language> if it is not already.
2. Find the feature by reading the page (read_page, find), not by guessing URLs. Use a test organizer/event/channel (name containing test, demo or QA).
3. Walk every step of: <list the steps>. Open editors and dialogs, then cancel. Never click Save, Delete or Send. Never type into credential fields.
4. One PNG per step, about 1440 wide, saved to <scratchpad>/<KEY>-shots/ as 01-slug.png, 02-slug.png. Use an available browser screenshot tool that saves a local image. If none is available, report the missing capability and leave a clearly marked image placeholder. Never print tokens or keys.
5. Record for each screen: navigation path as shown, exact labels, field names, helper texts, confirmations and messages visible without saving.

Return in English, under 100 lines: path, one bullet per screenshot (file, what it shows, labels visible), controls per screen, and anything that did not work.
```
