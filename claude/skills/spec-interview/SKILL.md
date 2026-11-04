---
name: spec-interview
description: Interview the PM about a rough idea or a gappy Discovery/ document, one question at a time, until a Discovery/ document from _template.md is filled in with agreed requirements unmarked and unresolved items marked Draft, Blocked or TBD. This is the deliberate, opt-in exception to the PM's default rule of "don't ask, propose a solution and let me react" - it runs only when they explicitly ask to be questioned, never on an ordinary problem description. Trigger phrases, Polish and English: "przepytaj mnie o X", "dopytaj mnie", "zróbmy refinement", "socratic", "refine this idea with me", "interview me about X".
argument-hint: <rough idea, or the Discovery/ document to refine>
---

You are running a structured interview with the Product Manager to turn a rough idea, or a gappy existing document, into a `Discovery/` document. While this skill runs, asking questions is the job - that overrides the PM's normal "don't ask, propose" rule. The moment the document is written, that override ends; go back to proposing, not asking.

The value of a question is that it makes the PM notice a gap they did not see, or that it tests an assumption against the vault. A question the vault or a past decision already answers is a wasted turn - state the answer and ask for confirmation instead.

---

## Step 0 - ground before the first question

Before asking anything:

1. Search `Discovery/` for an existing document on this topic - both a filename match and a grep for the key terms in the idea. Check whether a subfolder for this topic already exists (large topics like `Discovery/Fees/` have a lead document plus deep-dive files).
2. Read `Reference/<product>/` for how the area works today.
3. Read `Decisions.md` and `Roadmap.md` for anything already decided or scheduled about this topic.

Then send one opening message, in Polish, before any question: what already exists in the vault on this topic (name the files), and which sections of `_template.md` are therefore already answered. Only after that message, ask the first question.

Never ask what the vault already says. "Vault mówi X, trzymamy się tego?" is a valid question. "Co dziś robi system w tym obszarze?" is not, if `Reference/` already describes it - state it instead.

## Step 1 - scope check

If the idea, as described, is actually several independent features, say so now, before any refinement question - propose the split in one sentence per piece, and ask the PM which piece to refine in this run. Refine exactly one piece per run. If the idea is already a single feature, skip straight to Step 2.

## Step 2 - the interview

- One question per message. Never bundle two questions in one message.
- Use `AskUserQuestion` whenever the answer is a choice among known options. Put the option you'd recommend first and label it "(Recommended)". Leave a question open-ended only when forcing a choice would be artificial.
- For every question, name in one clause which part of the template it feeds (for example: "this decides the market scope in section 3") - not a heading, just the clause.
- Work through this coverage, in this order, skipping anything already answered in Step 0 or marked out of scope by the PM:
  1. Problem, and who raised it (section 3)
  2. Affected roles and markets (section 3)
  3. Confirmation of current state (section 2) - present what you found, get it confirmed or corrected
  4. General requirements (section 4)
  5. Per-market differences (section 4) - only for markets in scope, and ask whether the configured markets differ once, not once per market
  6. The assumption the proposed solution rests on (section 5)
  7. Success metrics (section 6)
  8. Dependencies and risks (section 5)
  9. Design needs (section 7)
- If the document already has Open Questions (section 8), each of them is a question in this interview, asked where its topic comes up in the coverage above - never carried over unasked. Three outcomes: the PM answers it and it becomes a requirement; the PM names who has to confirm it and it stays in section 8 with that owner; the PM drops it and it disappears.
- Once the PM marks something out of scope, drop it and do not bring it back later in the same run.
- Test assumptions with evidence, not opinion: "powiedziałeś X, `Reference/...` mówi Y - co obowiązuje?", "czy to przetrwa w rynku, gdzie Z?", "co się psuje, jeśli tego nie zrobimy?". Push back at most once per point - the PM's answer after that pushback is final, move on.
- Budget: aim for 8 to 12 questions total. Past question 12, stop asking and write the draft with what you have. The PM can also end the interview early at any point - "pisz", "wystarczy", "write it" all mean write the draft now, regardless of how many questions were asked. The open-questions round in Step 3 is one message on top of this budget and happens even after "pisz".

## Step 3 - write the document

- New topic: create `Discovery/<Feature name>.md` from `_template.md`. If Step 0 found an existing subfolder for this topic (for example `Discovery/Fees/`), put the new file there instead of the top level.
- Existing document: fill only the sections or fields that are empty or already marked Draft. Never rewrite a requirement already agreed. Never add a line about what changed or what this replaces - the document reads as if written from scratch, describing the feature, not its own history.
- Set `Status: Active`. This skill never sets `Status: Spec ready` - that decision is the PM's, after they read the finished file.
- Agreed requirements have no marker. Record their source and agreement date in section 10.
- Mark unresolved requirements only:
  - **Draft** - proposed during the interview but not agreed.
  - **TBD** - information not yet supplied.
  - **Blocked on Q-N** - depends on an open question, referenced by its number.
- Never write an open question the PM has not seen. Before writing the file, send one message, in Polish, with every candidate open question numbered. For each one the PM either answers it (it becomes an agreed requirement), names who has to confirm it (it goes into section 8 with an owner tag: `[UX]`, `[DEV]`, `[BIZ]`, or `[LEGAL]`), or drops it. Only what the PM neither answered nor dropped lands in section 8.
- Never invent a value. A fee, limit, VAT rate, or date the PM did not give stays blank in the table and becomes an open question instead - do not carry over a same-named number from an unrelated part of the vault.
- Document language: English. Chat with the PM: Polish. Dash style: hyphen-minus (`-`) only, never an em dash.

## Step 4 - self-review, then report

Before showing the file to the PM, read it once and fix, silently, without narrating the check:
- any placeholder text or template comment (`<!-- ... -->`) left in place
- any two sections that contradict each other
- any requirement that can be read two different ways
- any scope that grew past the single piece the PM picked in Step 1

Then report in chat, in Polish, in this order: where the file is, how many requirements are agreed, how many Draft, how many Blocked, and the open questions with their owner tags. Three to six sentences, complete sentences - no arrow chains, no compressed fragments.

---

## What this skill must not do

- Never add a row to `Todo.md`. Open items belong in the document's section 8, Open Questions, nowhere else.
- Never create a Jira ticket or a Confluence page, and never send anything outside the vault.
- Never edit `Reference/`, `Decisions.md`, or `Roadmap.md`. If the interview shows that a `Reference/` document is wrong, say so in chat and record it as a line in section 9, Working notes, of the Discovery document - do not touch `Reference/` itself.
- Never use code-development vocabulary - no commits, no tests, no TDD, no "files touched", no implementation plans. This is a product discovery interview, not an engineering handoff.

---

Idea or `Discovery/` document to refine:

$ARGUMENTS
