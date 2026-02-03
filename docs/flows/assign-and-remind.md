# Assign and Remind Flow

## Purpose
Generate assignments when policies publish, handle onboarding packs, drive annual re-acknowledgements, and manage reminders/escalations with duplicate prevention and exceptions.

## Triggers
- Publish event: new PolicyVersion created.
- Scheduled: daily assignment check and reminders.

## Assignment Creation (On Publish)
1. Read PolicyVersion and linked Policy.
2. Resolve AudienceRules to target People.
3. Create Assignment per Person with Status=Pending, AssignedDate=now, DueDate=Policy-defined.
4. Do not create if an active Assignment already exists for the same Person + PolicyVersion.

## Onboarding “Policy Pack”
- On a new Person record (or Active=true transition), assign the onboarding pack:
  - Use a configured list of required PolicyVersions.
  - Set DueDate based on onboarding SLA.
  - Skip if the Person already has a Completed or Pending Assignment for that PolicyVersion.

## Annual Re-Acknowledgement
- Scheduled run identifies Policies with annual re-ack required.
- For each Person who previously completed an acknowledgement:
  - Create a new Assignment for the latest PolicyVersion if last acknowledgement is older than 12 months.
  - Do not create if a Pending Assignment already exists.

## Reminder Schedule and Escalation
- Reminder cadence: e.g., 7 days before due, on due date, 7 days overdue.
- Escalation: after N days overdue, notify manager or policy owner.
- Log each reminder attempt with FlowRunId and timestamp.

## Duplicate Prevention Rules
- Assignment uniqueness key: Person + PolicyVersion.
- For re-ack cycles, enforce one Pending assignment at a time per Person + Policy.
- Idempotent runs: if an Assignment exists, skip creation.

## Exception Override Behavior
- If an approved Exception exists for the Assignment:
  - Suppress reminders and escalation.
  - Status may remain Pending, but flagged as Exception.
- If Exception is rejected or expired:
  - Resume standard reminder/escalation flow.
