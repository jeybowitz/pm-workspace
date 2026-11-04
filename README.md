# PM workspace

A reusable Markdown workspace for product managers working with AI: sources, discovery, requirements, ticket drafts and weekly planning.

Give an assistant persistent product context and repeatable working rules. The PM owns decisions and reviews the output. This repository contains templates and procedures, with no claimed productivity results.

## Start here

1. Read the [fictional walkthrough](examples/room-booking/README.md).
2. Follow the [setup guide](docs/SETUP.md) to create a private working copy.
3. Fill [Workspace Config.md](vault/Workspace%20Config.md) and add a factual source note to Reference/.
4. Ask your assistant to draft a feature with the [Discovery template](vault/Discovery/_template.md), citing that source and marking unknowns TBD.

A text editor and an assistant able to read Markdown are enough for local drafting. Obsidian is optional. The 12 skills were written for Claude Code; other assistants can use shared instructions and templates, but tool names and interactive steps may need adaptation. Live integrations have not been tested in this distribution.

## Contents

| Location | Purpose |
| --- | --- |
| CLAUDE.md and AGENTS.md | Shared rules and agent entry point |
| vault/ | Templates, configuration, processes and empty work folders |
| claude/skills/ | Optional workflows |
| claude/memory/ | Empty starting point for private feedback |
| claude/settings.json | Empty baseline, no personal plugins or permissions |
| claude/hooks/ | Optional push hook example with documented limits |
| examples/room-booking/ | Fictional source, spec, tickets and review |

## Skills

Install only the workflows you need. These are instructions for an assistant; connector and tool availability depend on the host environment. Publishing or sending content requires the authorization described by each workflow.

| Skill | What it does | Requirements and limits |
| --- | --- | --- |
| [morning](claude/skills/morning/SKILL.md) | Prepare a daily briefing from tasks, weekly outcomes and calendar; carry existing tasks forward. | Local planning files; optional Jira, calendar and messaging reads. |
| [friday-review](claude/skills/friday-review/SKILL.md) | Review outcomes, close a week and prepare the next weekly plan with the PM. | Planning files; calendar access for meeting context. |
| [wrap-up](claude/skills/wrap-up/SKILL.md) | Update existing task statuses from the conversation and propose new tasks for approval. | Todo.md and the current conversation. |
| [monthly-planning](claude/skills/monthly-planning/SKILL.md) | Draft a monthly planning page using past plans and verified epic status. | Confluence and Jira; saves a local draft. |
| [ingest](claude/skills/ingest/SKILL.md) | Compare a new source with existing knowledge and propose where to save its findings. | Source files or connected sources; confirmation before writing. |
| [spec-interview](claude/skills/spec-interview/SKILL.md) | Ask focused questions to turn an idea into a Discovery document. | Local product context and PM decisions; explicitly requested interview. |
| [analyze](claude/skills/analyze/SKILL.md) | Map current behavior against source code, including rules, variants and side effects. | Configured repositories and product documentation. |
| [jira](claude/skills/jira/SKILL.md) | Draft or review epics, stories and technical tasks using shared templates. | Product context; Jira read access when verifying existing issues. Drafts only. |
| [cto-review](claude/skills/cto-review/SKILL.md) | Review a spec or tickets for technical gaps, dependencies and risks, with code evidence. | Configured source repositories and product documents. |
| [user-guide](claude/skills/user-guide/SKILL.md) | Create an illustrated feature guide as HTML and prepare a Confluence help page. | Verified feature context, browser screenshots and optional publishing tools; external artifact-design skill. |
| [release-note](claude/skills/release-note/SKILL.md) | Turn verified ticket changes into short factual release-note entries. | Jira access or supplied ticket content. |
| [release-announcement](claude/skills/release-announcement/SKILL.md) | Draft Polish Slack and English Teams announcements from release notes. | Confluence or supplied notes; sending requires explicit authorization. |

The catalog covers all 12 bundled skills. Live connector workflows have not been tested as part of this distribution. Configure product names, repository paths, channels, file keys and libraries before use.

## Jira templates

- [Epic template](claude/skills/jira/references/epic-structure.md)
- [Story template](claude/skills/jira/references/story-structure.md)
- [Ticket writing rules](claude/skills/jira/references/style-rules.md)

Each template includes a section skeleton to copy. The Jira skill reads these same files when preparing drafts.

## Workflow

Sources → Discovery → PM review → Spec ready → local ticket drafts → review.

Feature files stay in Discovery/. Publication to external systems is separately authorized. Start with local files, then enable only the integrations you need.

Optional workflows retain generic domain examples and Polish conventions. Adapt them to your glossary and language. Personal conversation archives are excluded.

See [setup and dependencies](docs/SETUP.md), [contribution guidance](CONTRIBUTING.md) and the [MIT license](LICENSE).
