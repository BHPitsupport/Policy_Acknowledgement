# Sync People (Nightly)

## Purpose
Nightly synchronization of members of a designated Entra security group into the Dataverse `Person` table.

## Trigger
- Scheduled: daily off-peak run.

## Step-by-Step Design
1. Read the target Entra security group ID from configuration.
2. Query Graph for group members with paging enabled.
3. For each member:
   - Upsert `Person` using alternate key `EntraObjectId`.
   - Update DisplayName, UserPrincipalName, Mail, Department, Active=true.
   - Set `LastSeenOn` to current timestamp.
4. After processing all members:
   - Mark leavers by setting Active=false where `LastSeenOn` is older than this run.
   - Do not delete `Person` records.
5. Write a sync summary record to `SystemLog` with counts (total, inserted, updated, deactivated, errors).

## Paging and Throttling
- Use Graph `$top` and `@odata.nextLink` for paging.
- Respect Graph throttling headers and retry with exponential backoff.
- Batch Dataverse upserts where possible.

## Error Handling
- Transient Graph or Dataverse errors: retry with backoff and log warnings.
- Hard failures: log Error/Critical and alert owners.

## Required Microsoft Graph Permissions (High Level)
- Read group members (e.g., GroupMember.Read.All).
- Read user profiles (e.g., User.Read.All).

## Notes
- Maintain a `LastSeenOn` DateTime column on `Person` for leaver detection.
