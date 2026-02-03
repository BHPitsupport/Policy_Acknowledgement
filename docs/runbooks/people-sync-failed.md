# People Sync Failed (Graph/Auth)

## Symptoms
- Nightly sync flow fails with authentication or Graph errors.
- No updates to Person table; SystemLog shows Error/Critical.

## Checks
- Review flow run history for Graph error codes.
- Confirm app registration permissions and admin consent.
- Validate client secret/certificate expiration.

## Fix
- Renew credentials and update the connection.
- Re-run the sync flow manually.
- Verify new SystemLog entry indicates success.

## Prevention
- Use certificate-based auth with rotation schedule.
- Monitor credential expiry with proactive alerts.
- Keep permissions least-privilege and documented.
