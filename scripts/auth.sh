#!/usr/bin/env bash
set -euo pipefail

: "${PP_ENV_URL:?PP_ENV_URL is not set. Example: https://contoso.crm.dynamics.com}"

AUTH_NAME="${PP_AUTH_NAME:-policy-ack}"

echo "Creating auth profile '$AUTH_NAME' for $PP_ENV_URL"
pac auth create --url "$PP_ENV_URL" --name "$AUTH_NAME"

echo "Listing auth profiles"
pac auth list

echo "Selecting auth profile '$AUTH_NAME'"
pac auth select --name "$AUTH_NAME"
