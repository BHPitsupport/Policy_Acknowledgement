param(
    [string]$AuthName = $env:PP_AUTH_NAME
)

if (-not $env:PP_ENV_URL) {
    Write-Error "PP_ENV_URL is not set. Example: `$env:PP_ENV_URL = 'https://contoso.crm.dynamics.com'"
    exit 1
}

if (-not $AuthName) {
    $AuthName = "policy-ack"
}

Write-Host "Creating auth profile '$AuthName' for $env:PP_ENV_URL"
pac auth create --url $env:PP_ENV_URL --name $AuthName

Write-Host "Listing auth profiles"
pac auth list

Write-Host "Selecting auth profile '$AuthName'"
pac auth select --name $AuthName
