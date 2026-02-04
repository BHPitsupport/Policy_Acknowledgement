$repoRoot = Split-Path $PSScriptRoot -Parent
$solutionsDir = Join-Path $repoRoot "solutions"

if (-not $env:PP_SOLUTION_NAME) {
    Write-Error "PP_SOLUTION_NAME is not set. Example: `$env:PP_SOLUTION_NAME = 'Policy_Acknowledgement'"
    exit 1
}

$artifactsDir = if ($env:PP_ARTIFACTS_DIR) {
    if ([System.IO.Path]::IsPathRooted($env:PP_ARTIFACTS_DIR)) { $env:PP_ARTIFACTS_DIR } else { Join-Path $repoRoot $env:PP_ARTIFACTS_DIR }
} else {
    Join-Path $repoRoot "artifacts"
}

$zipPath = Join-Path $artifactsDir ("{0}_unmanaged.zip" -f $env:PP_SOLUTION_NAME)
$sourceDir = Join-Path $solutionsDir $env:PP_SOLUTION_NAME

New-Item -ItemType Directory -Force -Path $artifactsDir | Out-Null

Write-Host "Packing $sourceDir to $zipPath"
pac solution pack --zipfile $zipPath --folder $sourceDir --packagetype Unmanaged
