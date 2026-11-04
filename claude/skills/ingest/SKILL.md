---
name: ingest
description: Ingest a new source into the product vault - cross-reference it against existing knowledge first, propose where it fits, and write only after explicit confirmation. Use this skill whenever the user brings in fresh material to file - "zaingestuj to", "wrzuć to do vaulta", "gdzie to zapisać", "gdzie to wrzucić", "ingest this transcript", "add this source to the vault". Its main job is finding what is already documented before adding anything new, so reach for it even when the user only asks where something should go.
argument-hint: <source: file path, Confluence URL, Jira key or pasted text>
---

Ingest a new source into the <product> product vault. Cross-reference against what's already there, propose where it fits, and write only after explicit user confirmation.

The pain this solves: "kurde, gdzieś już było rozkminione, ale nie pamiętam gdzie." Ingestion's #1 job is finding existing knowledge BEFORE writing new stuff.

Vault root: the session's primary working directory. Every vault path in this document is relative to it.

## Source types and how to fetch them

| Source | How to fetch |
|---|---|
| File path in vault (`_Inbox/...`, `Meetings/Raw/...`) | Read tool |
| Confluence page (URL or page ID) | `mcp__claude_ai_Atlassian_Rovo__getConfluencePage` (markdown format) |
| Jira ticket (<JIRA_PROJECT>-XXX, <OTHER_PROJECT>-XX) | `mcp__claude_ai_Atlassian_Rovo__searchJiraIssuesUsingJql` with `key = X` |
| External URL (gist, blog, doc) | WebFetch |
| Figma frame | `mcp__claude_ai_Figma__get_design_context` |
| Pasted prose / verbal claim from user | Treat input itself as the source |
| Code finding | Bash grep against the repos under `~/repos/<company>/` (listed in `Reference/Repos.md`) |

If source type is unclear from the user's input, ask once with AskUserQuestion. Don't guess.

## Workflow

### Step 1 - Fetch and extract

Read the source. Pull out three things only:

- **Facts** - things claimed about how the product/market/process works
- **Decisions** - things someone chose to do or not do
- **Open questions** - things explicitly unresolved

Skip narrative, opinions without a basis, anything that's just context for the reader. Be aggressive about cutting.

### Step 2 - Cross-reference against vault (THE HIGH-VALUE STEP)

For each fact/decision, find what already exists. Use:

1. The area MOCs - `Discovery/_Discovery.md`, `Reference/<product>/_<product>.md`, `Reference/Legacy/_Legacy.md`, `Reference/Data/_Data.md`, `Research/_Research.md`. These index their folders including subfolders; step 5 keeps them that way.
2. For anything the source presents as a decision, check `Decisions.md` (vault root) - the global decision log. A source that restates a logged decision is DUPLICATE; a source that contradicts one is CONFLICT, never a silent UPDATE.
3. For claims about timing, scope or priority, check `Roadmap.md` (vault root).
4. For anything said in a meeting, check `Meetings/Index.md` - the meeting notes are not reachable from any MOC.
5. Grep on vault for keywords from the finding
6. Grep on `Reference/<product>/`, `Reference/Legacy/`, `Reference/Data/`, `Discovery/`, `Research/`, `Reference/Integrations/`

`Reference/Integrations/` (email providers, payment providers, tracker docs) is linked from no MOC - it is reachable only by grep, so always include it.

A MOC miss is not proof the topic is new - always grep before classifying anything as NEW.

`Jira/` holds drafted tickets written from Discovery docs, not primary knowledge. Don't cross-reference against it; verify Jira claims against live Jira instead (below).

Which document is canonical is declared by the documents themselves - a header note, a `status:` field, an `_archive/` location, or a `(shipped)` suffix. Read the header before treating a file as current.

For Jira/code claims, also verify:
- Jira ticket actually says what user/source claims (use Atlassian MCP)
- Code actually behaves as claimed (grep the repos under `~/repos/<company>/`)

Don't trust the source uncritically. If the source contradicts code, code wins. If two stakeholders disagree, flag it - don't silently pick one.

### Step 3 - Classify each finding

| Status | Meaning | Action |
|---|---|---|
| DUPLICATE | Already documented, same claim | Skip (note in log only) |
| UPDATE | Extends or contradicts existing page | Propose edit to that page |
| NEW | Novel topic, no related page | Propose where to file (Reference / Discovery / Research / Data) |
| CONFLICT | Contradicts existing claim AND can't tell which is right | Flag, ask user which is canonical |

### Step 4 - Show user the plan BEFORE writing

Use this output format:

```
## Ingestion: [source title or URL]

**Source:** [type, link, who/when if known]

### Extracted
**Facts:**
- ...
**Decisions:**
- ...
**Open questions:**
- ...

### Cross-reference
| Finding | Existing vault page | Status |
|---|---|---|
| X | [[Pricing model]] | DUPLICATE |
| Y | [[Reference/Markets|Markets]] | UPDATE - extends EE row |
| Z | (none) | NEW - propose `Reference/<product>/Q.md` |
| W | [[Reference/Markets|Markets]] (line 42) | CONFLICT - source says PL VAT 23%, vault says 8% |

### Proposed actions
1. Update [[Pricing model]] - section "Discount logic", add finding Y
2. New file `Reference/<product>/Q.md` for finding Z; also add `[[Q]]` to `Reference/<product>/_<product>.md` (the area MOC)
3. Append entry to [[Ingest Log]]

### Need decision from you
- W (CONFLICT): which is canonical?
- Z: Reference or Discovery? I'd say Reference because [reason] but check.
```

WAIT for user response. Don't write anything yet.

### Step 5 - Execute on confirmation

After user confirms (or adjusts):
- Apply the proposed edits / new files
- **If a NEW file was created**, also add a wikilink to the appropriate area MOC (`_<product>.md`, `_Discovery.md`, `_Research.md`, `_Legacy.md`, `_Data.md`) under the relevant subsection. The MOC is the graph hub; new files must be linked there to be discoverable. A new file in `Reference/Integrations/` goes into `_<product>.md` under its "Integrations" section - that folder has no MOC of its own.
- Append entry to [[Ingest Log]] (create if missing) with this structure:

```markdown
## YYYY-MM-DD - [source title]

**Source:** [link/path]
**Files touched:** [list of [[wikilinks]] or paths]
**Key claims:**
- ...
**Open questions:**
- ...
```

- Confirm what was done in 2-3 lines

## Style rules

The vault's own writing rules govern anything written here - language, the dash convention, business-level phrasing, the words-to-avoid table and the surname convention all live in `Process/Writing Style.md` in the vault. Read it rather than working from memory, because that table grows. The short version, so nothing gets written before it is read: vault files in English, conversation in Polish, `-` and not an em dash, no code field names or enums or routes, surnames truncated to "the designer".

These two are specific to ingestion and are not in `Process/Writing Style.md`:

- **Vault references use Obsidian wikilinks `[[Filename]]`**, not markdown paths. Use pipe alias `[[Path/Filename|Display]]` only when filename is not unique in vault. Paths break when a file is renamed; wikilinks survive it, and only wikilinks show up in the Obsidian graph.
- New files must be added to the relevant area MOC (`_FolderName.md`) so they appear in the Obsidian graph
- Conversation with user in Polish

## What NOT to do

- Don't ingest your own analysis. Ingest external sources, not summaries you just generated.
- Don't write before confirming. The cross-ref report is the deliverable; writes are step 5.
- Don't pad the log. One entry per source, not per finding.
- Don't restructure the vault to fit the source. Make the source fit existing structure.
- Don't create a new folder unless really warranted. Existing folders (Reference/ incl. Reference/Data/, Discovery/, Research/, Meetings/, Stakeholders/) cover almost everything.
