# Cancel an upcoming room booking

**Owner:** PM
**Status:** Spec ready
**Product:** Roomboard (fictional)

## 1. TL;DR

Employees can cancel their own upcoming room bookings and release the room without contacting the office coordinator.

## 2. Context

The coordinator currently cancels bookings manually. Cancelled bookings remain in history and no longer block availability. Source: [fictional source notes](source.md).

## 3. Problem

Employees depend on the coordinator to release rooms they no longer need. Employees and the coordinator are affected.

## 4. Requirements

| # | Requirement | User story | Notes |
| --- | --- | --- | --- |
| 1 | Cancelling an upcoming booking | As an employee, I want to cancel my upcoming booking so that others can use the room. | - Owner only, before the start instant<br>- Booking retained as cancelled; slot released<br>- Repeat request returns cancelled state<br>- Failed save leaves booking active; failure shown with retry |

### Cross-cutting acceptance criteria

| Feature | Acceptance criteria | Comment |
| --- | --- | --- |
| Time boundary | Cancellation refused at or after the start instant | Apply the same instant regardless of display time zone |
| Existing operations | Coordinator cancellation remains unchanged | No new coordinator capability |

## 5. Risks and dependencies

The cancellation and availability change must succeed together. A request arriving at the start boundary may be refused even if the screen previously showed the action as available. Calendar integration, email, series bookings and deletion are outside scope.

## 6. Success Metrics

| Metric | Baseline | Target | How measured |
| --- | --- | --- | --- |
| Self-service share of eligible cancellations | TBD | TBD | Owner self-service cancellations divided by all cancellations made before start for owner-held bookings, over the same reporting period |

PM accepts unknown baseline and target as nonblocking for this example. Collect the baseline before setting the target; no improvement is claimed.

## 7. Design Needs

Show cancellation availability, cancelled state and save failure with retry. Layout is left to the designer.

## 8. Open Questions

None in the simulated scope.

## 9. Working notes

None.

## 10. AI Context

All facts and decisions come from source.md, an authored fictional source. No repository, API or live product was checked. Spec ready represents the simulated PM decision only.

### Decision log

| Question | Decision | Rationale | Date |
| --- | --- | --- | --- |
| What is the cutoff? | Strictly before the start instant | One unambiguous eligibility boundary | Undated fictional scenario |
| Delete the record? | Keep cancelled history | Preserve visibility of the booking outcome | Undated fictional scenario |
| Add emails? | Outside scope | No existing integration in the source | Undated fictional scenario |
