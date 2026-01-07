param(
    [string]$FirmwareDir = ".\firmware",
    [string]$Branch = "add-gta-assets"
)

if (-not (Test-Path $FirmwareDir -PathType Container)) {
    Write-Error "Firmware directory '$FirmwareDir' not found"
    exit 1
}

Push-Location $FirmwareDir
# Ensure branch
$cur = git rev-parse --abbrev-ref HEAD
if (git show-ref --verify --quiet refs/heads/$Branch) {
    git checkout $Branch
} else {
    git checkout -b $Branch
}
Pop-Location

# Ensure destination folders exist
$destGta = Join-Path $FirmwareDir "assets\gta"
$destFonts = Join-Path $FirmwareDir "assets\fonts"
$destIcons = Join-Path $FirmwareDir "assets\icons"
New-Item -Path $destGta -ItemType Directory -Force | Out-Null
New-Item -Path $destFonts -ItemType Directory -Force | Out-Null
New-Item -Path $destIcons -ItemType Directory -Force | Out-Null

# Copy assets
Copy-Item -Path "GTA\*" -Destination $destGta -Recurse -Force -ErrorAction SilentlyContinue

# Copy fonts (.u8f)
if (Test-Path "Fonts") {
    Get-ChildItem -Path Fonts -Filter "*.u8f" -File -ErrorAction SilentlyContinue | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $destFonts -Force
    }
}

# Copy icons
if (Test-Path "Icons") {
    Copy-Item -Path "Icons\*" -Destination $destIcons -Recurse -Force -ErrorAction SilentlyContinue
}

# Add README in assets/gta
$readme = @'
GTA Asset Pack

This folder was automatically added by the GTA-Asset-Pack repository.
It contains animations (.bm + meta.txt), fonts (.u8f) and icons (.bmx). Adjust placement if necessary for apps.
'@
Set-Content -Path (Join-Path $destGta 'README.md') -Value $readme -Force

# Commit
Push-Location $FirmwareDir
try { git add assets/gta assets/fonts assets/icons } catch { }
$diff = git diff --cached --name-only
if (-not $diff) {
    Write-Output "No changes to commit."
} else {
    git commit -m "Add GTA Asset Pack: animations, fonts, icons"
}
Pop-Location

Write-Output "Patch applied to $FirmwareDir on branch $Branch"
