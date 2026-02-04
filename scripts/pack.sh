#!/usr/bin/env bash
set -euo pipefail

: "${PP_SOLUTION_NAME:?PP_SOLUTION_NAME is not set. Example: Policy_Acknowledgement}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
ARTIFACTS_DIR="${PP_ARTIFACTS_DIR:-artifacts}"
SOLUTIONS_DIR="$REPO_ROOT/solutions"

if [[ "$ARTIFACTS_DIR" != /* ]]; then
  ARTIFACTS_DIR="$REPO_ROOT/$ARTIFACTS_DIR"
fi

ZIP_PATH="$ARTIFACTS_DIR/${PP_SOLUTION_NAME}_unmanaged.zip"
SOURCE_DIR="$SOLUTIONS_DIR/$PP_SOLUTION_NAME"

mkdir -p "$ARTIFACTS_DIR"

echo "Packing $SOURCE_DIR to $ZIP_PATH"
pac solution pack --zipfile "$ZIP_PATH" --folder "$SOURCE_DIR" --packagetype Unmanaged
