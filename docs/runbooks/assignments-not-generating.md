# Assignments Not Generating

## Symptoms
- New PolicyVersion published but no Assignments created.
- Users do not see the policy in Pending list.

## Checks
- Confirm AudienceRules exist and are Active.
- Verify assignment flow run history for errors.
- Check PolicyVersion and Policy status (Active).

## Fix
- Correct AudienceRule configuration and re-run assignment flow.
- Manually trigger assignment generation for the PolicyVersion.
- Validate Assignment records exist in Dataverse.

## Prevention
- Add validation to ensure at least one active AudienceRule on publish.
- Monitor assignment flow with failure alerts.
- Include assignment counts in SystemLog summaries.
