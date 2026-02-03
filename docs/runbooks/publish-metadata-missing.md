# Publish Flow Failed: Missing Metadata

## Symptoms
- Publish flow fails on a Master policy file update.
- SystemLog shows validation errors for missing metadata.
- PolicyVersion not created; file not copied to Published-Immutable.

## Checks
- Verify required metadata fields are present on the Master file.
- Confirm naming convention matches expected pattern.
- Check SystemLog for the exact missing field name.

## Fix
- Populate missing metadata on the Master file.
- Re-save the file to re-trigger publish.
- Confirm the flow completes and a PolicyVersion is created.

## Prevention
- Enforce metadata requirements with SharePoint column validation.
- Provide a policy publishing checklist for authors.
- Add a pre-publish validation step in the Power App.
