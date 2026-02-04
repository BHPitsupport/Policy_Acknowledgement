#!/usr/bin/env bash
set -euo pipefail

: "${PP_SOLUTION_NAME:?PP_SOLUTION_NAME is not set. Example: Policy_Acknowledgement}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
ARTIFACTS_DIR="${PP_ARTIFACTS_DIR:-artifacts}"

if [[ "$ARTIFACTS_DIR" != /* ]]; then
  ARTIFACTS_DIR="$REPO_ROOT/$ARTIFACTS_DIR"
fi

ZIP_PATH="$ARTIFACTS_DIR/${PP_SOLUTION_NAME}_unmanaged.zip"

mkdir -p "$ARTIFACTS_DIR"

echo "Exporting unmanaged solution '$PP_SOLUTION_NAME' to $ZIP_PATH"
pac solution export --name "$PP_SOLUTION_NAME" --path "$ZIP_PATH" --managed false
