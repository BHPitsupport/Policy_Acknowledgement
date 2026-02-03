# Audit Pack Export

## Purpose
Generate an audit export for a specified date range and store it in the SharePoint `AuditPacks` library.

## Trigger
- Manual: Admin-initiated from Power App or flow.
- Scheduled: optional periodic export (e.g., monthly/quarterly).

## Inputs
- StartDate (required)
- EndDate (required)
- Policy (optional filter)

## Outputs
- CSV/Excel files in `AuditPacks`:
  - acknowledgements.csv (who/what/version/when)
  - policy_versions.csv (version list + immutable URLs + file hashes)
  - exceptions.csv
  - system_health.csv (last sync, last publish, flow failures)

## Step-by-Step Design
1. Validate input date range and optional policy filter.
2. Query Acknowledgements within date range:
   - Include Person, Policy, PolicyVersion, AcknowledgedTimestamp.
3. Query PolicyVersions within date range:
   - Include VersionNumber, PublishedDate, ImmutableUrl, FileHash.
4. Query Exceptions within date range:
   - Include Assignment, Person, Reason, Status, ApprovedBy, ApprovedOn.
5. Query SystemLog for health metrics:
   - Last successful sync run
   - Last publish run
   - Flow failures in range
6. Generate CSV/Excel outputs from each dataset.
7. Upload files to `AuditPacks` with a timestamped folder or prefix.
8. Write completion entry to SystemLog with file links.

## Error Handling
- Log validation errors and abort without output.
- Retry transient failures for Graph/Dataverse/SharePoint.
- On failure, log SystemLog with Severity=Error/Critical and alert admins.

## Notes
- Use consistent column naming and include UTC timestamps.
- Store file hashes and immutable URLs for verification.
