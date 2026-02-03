# Policy Acknowledgement

## Objective
Provide a governed, auditable Power Platform solution that captures policy acknowledgements with minimal manual administration.

## Scope
- Dataverse: core data model and security roles
- Power Apps: user-facing acknowledgement app
- Power Automate: notifications, reminders, and evidence capture
- SharePoint: document storage for policies and evidence exports
- Microsoft Graph: user lookup and directory-based targeting

## Architecture Summary
The solution is packaged as a Dataverse solution with aligned Power Automate flows and a Power Apps front end. Audit evidence is stored alongside policy documents, and operations are designed to run automatically with least-privilege service principals.

## Build Workflow (Export/Unpack/Commit)
1. Export the managed/unmanaged solution from the environment.
2. Unpack the solution into `solutions/`.
3. Commit solution artifacts and related documentation changes.

## Zero-Admin Design Goals
- No manual intervention for routine runs (only for critical failures).
- Least-privilege service accounts and app registrations.
- Automated evidence capture and audit-friendly logs.
- Runbooks for exception handling and recovery.
- Clear separation between configuration and solution artifacts.
