$repoRoot = Split-Path $PSScriptRoot -Parent

if (-not $env:PP_SOLUTION_NAME) {
    Write-Error "PP_SOLUTION_NAME is not set. Example: `$env:PP_SOLUTION_NAME = 'Policy_Acknowledgement'"
    exit 1
}

$artifactsDir = if ($env:PP_ARTIFACTS_DIR) {
    if ([System.IO.Path]::IsPathRooted($env:PP_ARTIFACTS_DIR)) { $env:PP_ARTIFACTS_DIR } else { Join-Path $repoRoot $env:PP_ARTIFACTS_DIR }
} else {
    Join-Path $repoRoot "artifacts"
}

New-Item -ItemType Directory -Force -Path $artifactsDir | Out-Null
$zipPath = Join-Path $artifactsDir ("{0}_unmanaged.zip" -f $env:PP_SOLUTION_NAME)

Write-Host "Exporting unmanaged solution '$($env:PP_SOLUTION_NAME)' to $zipPath"
pac solution export --name $env:PP_SOLUTION_NAME --path $zipPath --managed false
