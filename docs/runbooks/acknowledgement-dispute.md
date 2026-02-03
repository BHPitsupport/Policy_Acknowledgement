# User Claims Acknowledged but System Disagrees

## Symptoms
- User reports they submitted acknowledgement but Assignment remains Pending.
- Acknowledgement record is missing or incomplete.

## Checks
- Search Acknowledgement table by Person and PolicyVersion.
- Review flow run history for submission errors.
- Confirm the user opened the correct policy version.

## Fix
- If record exists, update Assignment.Status to Completed.
- If record missing, re-submit attestation on behalf of user.
- Log manual correction in SystemLog.

## Prevention
- Add confirmation receipt to users with timestamp and PolicyVersion.
- Ensure app handles intermittent network failures with retry.
- Capture FlowRunId on acknowledgement submissions.
