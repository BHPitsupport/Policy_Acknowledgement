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
TARGET_DIR="$SOLUTIONS_DIR/$PP_SOLUTION_NAME"

mkdir -p "$TARGET_DIR"

echo "Unpacking $ZIP_PATH to $TARGET_DIR"
pac solution unpack --zipfile "$ZIP_PATH" --folder "$TARGET_DIR" --packagetype Unmanaged
