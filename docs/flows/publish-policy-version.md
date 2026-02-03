# Publish Policy Version Flow

## Trigger
- SharePoint: When a file is created or modified in `Masters`.

## Step-by-Step Design
1. Read file metadata from `Masters` (policy code, title, version, effective date, owner).
2. Validate required metadata fields and data types.
3. Validate naming convention:
   - File name pattern: `{PolicyCode}_v{VersionNumber}_{YYYYMMDD}.pdf`
4. Check for existing PolicyVersion in Dataverse:
   - Match on PolicyCode + VersionNumber + FileHash.
   - If found, exit successfully (idempotent rerun).
5. Create or update Policy record (if missing or Draft).
6. Copy file to `Published-Immutable` library with read-only permissions.
7. Write immutable URL, file hash, and published date back to Dataverse.
8. Create new PolicyVersion record with immutable fields.
9. Supersede logic:
   - Find prior Active PolicyVersion for the Policy.
   - Mark prior version as superseded and set SupersededDate.
10. Update Policy.CurrentVersionId to the newly published version.

## Error Handling and Alerts
- Validation failures: log to SystemLog with Severity=Warning and notify owner.
- Copy or Dataverse failures: log to SystemLog with Severity=Error/Critical and alert admins.
- Retries: enable platform retry for transient errors; avoid duplicates using idempotency key.

## Idempotency
- Idempotency key: `{PolicyCode}:{VersionNumber}:{FileHash}`
- Re-run behavior: if a PolicyVersion exists for the key, exit without changes.
