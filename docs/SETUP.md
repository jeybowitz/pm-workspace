# Setup

## Local workspace

Use Python 3 for the installer, a text editor and an assistant able to read local files. Obsidian and connectors are optional.

From the repository root:

```sh
python3 scripts/install_workspace.py /absolute/path/to/private-workspace
```

The destination must not exist and must be outside this repository. The installer copies vault files and CLAUDE.md only. It does not alter global settings, install skills or connect services.

Open that destination. Fill Workspace Config.md and add a factual source note to Reference/. Create Roadmap.md, Decisions.md, Reference/Repos.md and stakeholder files only when needed. Missing sources must stay unverified.

## Optional workflows

Copy only chosen skill directories into your assistant's supported skill location, keeping references, scripts and assets together. Read each skill before installing; configure its placeholders and tools. Installation conventions depend on the host assistant. No global settings need replacing.

| Skills | Required context or tools |
| --- | --- |
| spec-interview, jira | Local sources and PM decisions; Jira read access when checking existing tickets |
| morning, friday-review, wrap-up | Todo and Weekly Plan; connectors only for enabled external sources |
| ingest | Source files and format-specific readers |
| analyze, cto-review | Product repositories; review tools/agents named in the skill |
| monthly-planning, release-note, release-announcement | Configured Jira, Confluence and message destinations; authorized publication |
| user-guide | Browser tools; user-guide also expects an external artifact-design skill and publishing tools |

No historical memory is included. Add your own feedback only in your private workspace, and record its location in Workspace Config.md. Current shared rules take precedence.

## Hook limitations

The push hook is disabled by default. settings.json is empty. Configure deliberately and merge with existing settings instead of replacing them.

The push hook needs bash, jq, Git and an owner value. Its command-string parsing covers only some push forms; wrappers, Git options, push URLs and gh repo create --push are not fully covered. It is not a security boundary.


## Verification

Run `python3 scripts/validate_workspace.py`. It checks local distribution structure, links, identifying leftovers and installation into a temporary directory. It does not test live integrations or prove removal of all sensitive information.
