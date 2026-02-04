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

## Environment Config

Create a local environment file from the template (this file is gitignored):

PowerShell:

```powershell
Copy-Item .\config\env.template.ps1 .\config\env.local.ps1
. .\config\env.local.ps1
```

Bash:

```bash
cp ./config/env.template.sh ./config/env.local.sh
source ./config/env.local.sh
```

## Power Platform CLI Helpers

These helper scripts wrap common `pac` actions. They rely on environment variables and do not store secrets.

PowerShell examples:

```powershell
. .\config\env.local.ps1

.\scripts\auth.ps1
.\scripts\export.ps1
.\scripts\unpack.ps1
.\scripts\pack.ps1
```

Bash examples:

```bash
source ./config/env.local.sh

./scripts/auth.sh
./scripts/export.sh
./scripts/unpack.sh
./scripts/pack.sh
```

Outputs:
- Unmanaged solution zip: `artifacts/<SolutionUniqueName>_unmanaged.zip`
- Unpacked solution folder: `solutions/<SolutionUniqueName>/`

## CI Validation

A minimal GitHub Actions workflow runs on pushes and PRs to keep the repo tidy:
- Checks basic repo structure (`README.md`, `scripts/`, `config/`, `solutions/`).
- Scans for obvious secret patterns (no secrets required).
- Ensures any solution under `solutions/` is unpacked (expects `solution.xml`).
