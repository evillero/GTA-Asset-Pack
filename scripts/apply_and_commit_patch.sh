#!/usr/bin/env bash
set -euo pipefail

FIRMWARE_DIR="$1"
BRANCH="$2"
ROOT_DIR="$(pwd)"

if [ ! -d "$FIRMWARE_DIR" ]; then
  echo "Firmware directory '$FIRMWARE_DIR' not found"
  exit 1
fi

cd "$FIRMWARE_DIR"
# create branch
if git show-ref --verify --quiet refs/heads/$BRANCH; then
  git checkout $BRANCH
else
  git checkout -b $BRANCH
fi
cd "$ROOT_DIR"

# Ensure destination folders exist
mkdir -p "$FIRMWARE_DIR/assets/gta"
mkdir -p "$FIRMWARE_DIR/assets/fonts"
mkdir -p "$FIRMWARE_DIR/assets/icons"

# Copy assets
rsync -av --delete GTA/ "$FIRMWARE_DIR/assets/gta/"

# Copy fonts (.u8f) if any
if compgen -G "Fonts/*.u8f" > /dev/null; then
  cp -n Fonts/*.u8f "$FIRMWARE_DIR/assets/fonts/" || true
fi

# Copy icons
if [ -d "Icons" ]; then
  rsync -av --delete Icons/ "$FIRMWARE_DIR/assets/icons/"
fi

# Add a short README in the assets folder to explain origin
cat > "$FIRMWARE_DIR/assets/gta/README.md" <<'EOF'
GTA Asset Pack

This folder was automatically added by the GTA-Asset-Pack repository (https://github.com/your/repo).
It contains animations (.bm + meta.txt), fonts (.u8f) and icons (.bmx). Adjust placement if necessary for apps.
EOF

# Commit changes (if any)
cd "$FIRMWARE_DIR"
git add assets/gta assets/fonts assets/icons || true
if git diff --cached --quiet; then
  echo "No changes to commit."
else
  git commit -m "Add GTA Asset Pack: animations, fonts, icons"
fi

echo "Patch applied to $FIRMWARE_DIR on branch $BRANCH"
