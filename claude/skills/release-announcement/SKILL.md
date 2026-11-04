---
name: release-announcement
description: Draft the two release-announcement posts for a <team> release - a Polish Slack post and an English Teams post - based on the release's Confluence release notes page. Use whenever the user wants to announce a release - "zrob release page", "przygotuj ogloszenie o release", "napisz post na slacka o release", "release announcement for <VERSION>". Drafts only, in chat; never posts to Slack or Teams without explicit confirmation.
argument-hint: [version number or Confluence/Slack/Teams link] [optional: angle for the Teams post]
---

Draft two release-announcement posts for a <team> release: one for Slack (Polish), one for Microsoft Teams (English). Both are built from the same source - the release's Confluence release notes page - and cover the same ground, just in different languages and slightly different framing per channel.

## Finding the release

The argument may be:
- A version number (e.g. `<VERSION>`) - search Confluence directly for it.
- A link (Confluence release notes page, or a past Slack/Teams message that references one) - resolve to the Confluence page ID and read it.
- Nothing - find the latest release yourself first, only ask the user if you can't.

**Auto-detecting the latest release:** run this CQL against Confluence (cloudId `<CLOUD_ID>`):
```
text ~ "Release Notes - <team>" AND space = <RELEASE_NOTES_SPACE> order by created desc
```
Take the newest result whose title actually starts with "Release Notes - <team>" (the same query may also return release pages from other teams in space <RELEASE_NOTES_SPACE> - skip those). Confirm the version number and date from the page's own header table before proceeding.

Only ask the user for the version/link when the search returns nothing, or when the top two results are ambiguous (e.g. two pages created the same day, or a hotfix page like `<VERSION_A>`/`<VERSION_B>` where it's unclear which one is "the release" being announced).

## Reading the source

Fetch the page with `mcp__claude_ai_Atlassian_Rovo__getConfluencePage` (or `_2`), `contentFormat: markdown`. Pull from it:
- **Version and release date** (header table).
- **Description section** - grouped by product area (one header per product area or application). This is the main source for what to write.
- **Feature Highlight section** - named features with more detail; use these to spot what the team itself considers the notable items.
- **Fixed Bugs** list at the bottom, if present - these plus small polish items in the Description feed the cleanup section.
- The ticket table only as backup context (story points, which product area) - never dump raw ticket titles into the announcement.

## Sorting into three buckets

Both posts use the same three buckets, applied by judgment, not by copying the Confluence area headers verbatim:
1. **New capabilities** - something that did not exist before (a new screen, a new toggle, a new report, a new channel).
2. **Key improvements** - existing behavior that changed or got better (redesigns, new settings on an existing flow, performance/infra changes that a stakeholder would still care about).
3. **Cleanup and fixes** - bug fixes and small polish (the Fixed Bugs list, plus minor Description items).

**Include everything that matters, not just the technical/infra angle.** Default to covering the full release, same substance in both posts. Only skew the selection toward a particular angle (e.g. "what does this mean for other markets") when the user explicitly asks for one via the optional angle argument - and even then, don't drop items that are independently important, just reweight emphasis and ordering.

Internal/dev-only tooling with no visible effect for any market or role (e.g. local Kubernetes chart setup, a library import, an internal security scoping change) is fair to leave out unless the user's requested angle is specifically about engineering/platform work.

## Style (non-negotiable)

Both posts follow `Process/Writing Style.md` - read it before drafting if it's not already fresh in context. In particular:
- No PR/marketing voice. No "brings us closer to", "strengthens", "lays the groundwork", "aligns with", "enhanced experience". State the fact plainly.
- Short sentences, plain verbs (have/remove/use, not carries/enables/drives).
- Check the Words to avoid table and swap anything that lands on it.
- `-` not `—`.
- The Polish post can keep the slightly warmer, bolded-feature-name tone of past posts (see examples below) - that's house voice, not PR-speak. The English Teams post is flatter and more literal - a plain translation of the same facts, not a re-sell.

## Output 1: Slack post (Polish)

Destination: channel `<SLACK_CHANNEL_ID>` (configure before publishing).

Suggested format:

```
:admission_tickets: *<team> <X.X.X> wejdzie na produkcję w nocy z <dzień1> na <dzień2>*

:new: *Nowe funkcje*
• ...

:zap: *Najważniejsze usprawnienia*
• ...

:broom: *Porządki i poprawki*
• ...

*Pełne informacje o release:*
<<confluence-url>|Release Notes - <team> - <X.X.X>>
```

**Deployment timing:** use only a schedule explicitly supplied by the source. Do not infer overnight deployment from a release date. When an overnight window is confirmed, these Polish weekday forms may help:

| night of ... | phrase |
| --- | --- |
| Sun → Mon | z niedzieli na poniedziałek |
| Mon → Tue | z poniedziałku na wtorek |
| Tue → Wed | z wtorku na środę |
| Wed → Thu | ze środy na czwartek |
| Thu → Fri | z czwartku na piątek |
| Fri → Sat | z piątku na sobotę |
| Sat → Sun | z soboty na niedzielę |

## Output 2: Teams post (English)

Destination: team id `<TEAMS_TEAM_ID>` ("<teams-team-name>"), channel id `<TEAMS_CHANNEL_ID>` ("<teams-channel-name>").

Suggested format:

```
<team> <X.X.X>

New capabilities
- ...

Key improvements
- ...

Cleanup and fixes
- ...

Full release notes:
<confluence-url as a link, title "Release Notes - <team> - X.X.X">
```

No opening summary paragraph before the bullets - past drafts that added one ("This release focuses on...") read as filler; go straight into the bullets. If the user gave an angle argument, a one-line subject can reflect it (e.g. "<team> <VERSION> - application integration"), but don't add prose framing beyond the subject line itself.

## Presenting the result

Show both drafts in chat, in full, one after the other, clearly labeled ("Slack (PL)" / "Teams (EN)"). Cite the source page (title + Confluence URL) and how the release was found (auto-detected latest / version given / link given).

**Never post to Slack or Teams on your own initiative.** Posting is a visible action to other people - always ask first ("wrzucić na Slacka / Teams, czy zostawiamy jako draft?"). Only call `mcp__claude_ai_Slack__slack_send_message` (channel `<SLACK_CHANNEL_ID>`) or `mcp__claude_ai_Microsoft_365__teams_send_channel_message` (team/channel above) after the user explicitly confirms, and confirm each channel separately if the user only approves one.

Don't save the drafts to the vault automatically - they're chat-only outputs like a Jira ticket draft. Save to `_Inbox/` only if the user asks.
