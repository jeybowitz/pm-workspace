# Source notes: Roomboard

Synthetic source for this example only.

Roomboard lets employees book meeting rooms. An employee can see their own bookings. Each booking records its owner, room, start, end and active/cancelled state. Times are stored as instants and displayed in the employee's selected time zone. Only active bookings block availability.

Today employees ask an office coordinator to cancel a booking. The coordinator marks it cancelled, which releases its time slot. No calendar or notification integration exists in this fictional product.

## Request

Employees want to cancel their own upcoming bookings without contacting the coordinator. Preserve the booking record for history.

## Simulated PM decisions

- Self-service cancellation is available to the owner only, strictly before the booking starts.
- At the start instant and afterwards, self-service cancellation is refused. The coordinator's existing process is unchanged.
- A cancelled booking remains visible with its status. Repeating cancellation returns the same cancelled state.
- If saving fails, the booking remains active; show a failure and allow a retry.
- Calendar integrations, emails, series bookings and deletion are outside scope.
- Measure the share of eligible cancellations completed through self-service. Baseline and target are unknown and accepted as nonblocking for this demonstration; collect a baseline before setting a target.
