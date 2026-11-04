# Fictional local ticket drafts

Prepared from discovery.md for demonstration. No tickets have been created in a tracker.

## Epic: Self-service room cancellation

### Outcome

Employees currently rely on the coordinator to cancel room bookings. Owners can cancel upcoming bookings themselves and release the room.

### Success metrics

Self-service share of eligible cancellations. Baseline and target TBD; the simulated PM accepts measurement setup as nonblocking.

### Scope

Owner cancellation before start, retained history and released availability. Calendar integration, email, series bookings and deletion are excluded.

### Done criteria

- Owner can cancel an eligible booking.
- Cancelled booking remains in history and no longer blocks the room.
- Ownership, time boundary, repeated request and save failure scenarios are checked.

### Dependencies

Existing booking ownership and coordinator cancellation behavior described in the fictional source. Implementation not verified.

### Risks

Availability and booking state must change together; eligibility can expire while the screen remains open.

### Open questions

None in the simulated scope.

## Story: Cancel an upcoming booking

### Story

As an employee, I want to cancel my upcoming booking so that others can use the room.

### Context

Cancellation currently requires the office coordinator. Owners need self-service cancellation for future bookings.

### As is

Only the coordinator cancels bookings; cancelled records remain in history and release availability.

### To be

Owners can cancel eligible bookings and see the cancelled result.

### Acceptance criteria

- Owner can cancel an active booking strictly before its start instant.
- Another employee cannot cancel it through self-service; the booking stays active.
- At or after the start instant, cancellation is refused and the active booking stays unchanged.
- Successful cancellation retains the record as cancelled and releases the room for its time slot.
- Repeating cancellation returns the cancelled state without additional changes.
- Failed save keeps the booking active and its slot occupied; the employee sees failure and can retry.
- Display time zone does not change eligibility.
- Coordinator cancellation remains unchanged.
- Calendar integration, email, series bookings and deletion are outside scope.
