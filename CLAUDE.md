# PM workspace instructions

This is a reusable Markdown workspace for product management. Product facts come from the adopter's own sources.

## Context and paths

In the repository, the vault is vault/, skills are claude/skills/, and an empty memory starting point is claude/memory/. When installed, this file sits at the vault root. Resolve paths accordingly.
Read Workspace Config.md in the vault for product context, language and integrations. Read Process/Writing Style.md before writing artifacts and Process/Vault Structure.md for statuses. Unfilled fields are unknown, never facts.
Use capabilities available in the current environment. If an integration is absent, work from supplied files and state what was not verified. Do not invent tool calls.

## Working rules

- Work with the PM as a peer. Recommend a concrete approach. Keep replies concise and expand when needed.
- Follow the user's language in chat; default artifacts to English. Both are configurable.
- Verify behavior against source documents or code before asserting it. Record provenance and commit/date when relevant. Say Not checked when verification is unavailable.
- Use TBD for missing values. Never invent metrics, limits, behavior or outcomes.
- Stay within the request. Prepare drafts locally. External writes require explicit user authorization for the action; preserve authorization already given.
- Do not add tasks to Todo.md without the user choosing them. Updating existing tasks is allowed within the request.
- Ask when missing information changes the result or the decision belongs to the PM. Resolve routine formatting yourself.
- Save requested artifacts in the relevant vault folder and report their location. Do not turn a chat question into an unsolicited document.
- Report only work performed. Separate supplied facts, proposals and verified behavior.

## Workflow

Keep one feature document in Discovery/ throughout its lifecycle. Stage is represented by Status, not by moving the file to another folder.
Use Discovery/_template.md. Sections 1-9 serve stakeholders; section 10 holds verification, technical notes and the decision log. Requirements use a table with user stories and checkable criteria. Agreed requirements have no marker. Mark unresolved content Draft, Blocked on Q-N or TBD; keep agreement sources in section 10.
Show candidate open questions to the PM before adding them. Record only retained questions, with an owner. Resolved decisions become requirements; rationale stays in section 10.
The PM sets Spec ready when sections 1-6 are complete and no unresolved requirement blocks implementation. Unknown metric baselines may stay TBD only if the PM explicitly accepts them as nonblocking.
Epics and bulk ticket drafts require Spec ready. Explicit single-story requests can start from chat. Drafting from a document below the gate requires the PM's agreement. Technical tasks may describe an existing technical decision; unresolved product scope returns to discovery.
Read the Jira skill before drafting or reviewing tickets. It produces local drafts; publication is a separate authorized action.

## Optional workflows

Install only needed skills. Missing connector steps remain unverified. Product-specific worked examples illustrate style and must not become requirements for another product.
Any memory added by the adopter is private context; current instructions and user choices take precedence. Keep product knowledge in Reference/ and reusable feedback reasoning in memory.
