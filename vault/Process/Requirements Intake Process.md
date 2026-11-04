# Requirements Intake Process — Multi-Market

## DRI Network

One person per market owns the requirements input. They are the single point of contact — not a team, not "local PM generally."

| Market | DRI | Role |
| --- | --- | --- |
| <Market A> | the PM | PM (internal) |
| <Market B> | <name> | Head of Product |
| <Market C> | <name> | Market PM |
| <Market D> | <name> | Contact person |

---

## Intake Sprint Cadence

- **Frequency:** once per feature/epic, or biweekly during active GAP analysis
- **Async phase:** DRI fills in the intake template within 5 business days
- **Sync phase:** 30-min validation call per market to resolve ambiguities (not to gather — to confirm)
- **Escalation:** no response within 5 days → PM escalates to DRI's manager

---

## Intake Template

Copy this template per feature/topic and send to each DRI.

```
## Requirements Intake — [Feature Name] — [Market]

Deadline: [DATE]
Filled by: [DRI name]

---

### 1. Current behavior
Describe how this works in your current system today (1-3 sentences or bullet points).

### 2. Volume / usage
How often is this used? Estimated number of transactions/events/users affected per month.
[ ] < 100   [ ] 100–1000   [ ] 1000–10000   [ ] > 10000   [ ] Unknown

### 3. Must-have requirements (blocker for go-live)
List only hard requirements — without these, the market cannot operate.

1.
2.
3.

### 4. Nice-to-have requirements (non-blocking)
List separately from must-haves.

1.
2.

### 5. Known differences from other markets
What is specific to your market that other markets likely don't have?

### 6. Open questions / blockers
What do you need clarified before you can answer fully?

### 7. Legal / regulatory constraints
Any local law, tax authority requirement, or compliance rule that affects this feature?

### 8. Examples / screenshots
Attach screenshots, export examples, or links to existing behavior if available.
```

---

## Rules for Using the Template

- **Never send open-ended questions** — always attach the template. Open questions get ignored.
- **One template per feature, not per call.** Send it before the call; the call is only to validate.
- **Force a ranking:** if DRI lists 10 must-haves, push back — ask them to pick top 3 blockers.
- **Section 7 is mandatory** for anything touching payments, invoices, VAT, or refunds.

---

## When to Use JPD Sessions

Joint Product Discovery (all markets in one session) is useful **after** intake, not instead of it:

- Align on which requirements conflict across markets
- Decide on a unified solution when markets have different but compatible needs
- Get buy-in before writing the spec

Do not use JPD for initial gathering — one loud market will dominate and others will stay silent.

---

## Tracking Intake Status

Maintain a simple table per epic/feature:

| Market | Template sent | Response received | Call done | Signed off |
| --- | --- | --- | --- | --- |
| <Market B> | | | | |
| <Market C> | | | | |
| <Market D> | | | | |
| <Market A> | | | | |
