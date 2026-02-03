# App UX

## User Screens

### My Pending Policies
- Shows active assignments where Status = Pending or Overdue.
- Actions: open policy detail.
- Query (Dataverse):
  - Assignment filtered by PersonId = CurrentUser and Status in (Pending, Overdue)
  - Join PolicyVersion and Policy for display fields
- Delegation notes:
  - Use Dataverse filters on indexed columns (PersonId, Status).
  - Avoid complex client-side filtering; use server-side filters.

### Completed Policies
- Shows completed acknowledgements with access to older versions.
- Actions: open policy detail for the acknowledged version.
- Query (Dataverse):
  - Acknowledgement filtered by PersonId = CurrentUser
  - Join PolicyVersion and Policy
- Delegation notes:
  - Filter on PersonId server-side; sort by AcknowledgedTimestamp.

## Policy Detail Screen
- Displays PolicyVersion metadata and immutable URL.
- Actions:
  - Open immutable document link.
  - Attest: checkbox + submit.
- Submit behavior:
  - Create Acknowledgement record with AcknowledgedTimestamp, Source=App, FlowRunId.
  - Update Assignment.Status = Completed and CompletedDate.
- Delegation notes:
  - Use Patch with direct record references to avoid delegation warnings.

## Admin Portal

### Search
- Search by Policy or User.
- Query options:
  - By Policy: filter Assignments by PolicyId or PolicyVersionId.
  - By User: filter Assignments or Acknowledgements by PersonId.
- Delegation notes:
  - Avoid non-delegable string operations on large datasets.
  - Prefer starts-with over contains for policy code or UPN where possible.

### Signed vs Not Signed Lists
- Signed: Acknowledgements filtered by PolicyVersion or Policy.
- Not Signed: Assignments with Status = Pending/Overdue for the same policy.
- Delegation notes:
  - Use server-side filters and explicit indexes on Status and PolicyVersionId.

### Export
- Export filtered results to CSV or send to AuditPack export flow.

### Exceptions
- View and manage Exception records linked to Assignments.
- Allow approval/rejection actions with audit notes.

## Notes
- Ensure all user-specific queries are filtered by PersonId resolved from Entra Object ID.
- Use delegated queries for large datasets; avoid local collection joins.
