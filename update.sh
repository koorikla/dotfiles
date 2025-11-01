#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Applying local dotfiles configuration..."

# Define date safely
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Resolve the absolute path of the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define configs to sync
CONFIGS=(
  ".config/sketchybar"
  ".config/borders"
  ".config/skhd"
  ".config/yabai"
)

for cfg in "${CONFIGS[@]}"; do
  SRC="$SCRIPT_DIR/$cfg"
  DEST="$HOME/$cfg"

  if [[ ! -e "$SRC" ]]; then
    echo "⚠️  Skipping missing $SRC"
    continue
  fi

  if [[ -d "$DEST" || -f "$DEST" ]]; then
    echo "📦 Backing up $DEST → ${DEST}_backup-$DATE"
    mv "$DEST" "${DEST}_backup-$DATE"
  fi

  echo "📂 Installing $cfg"
  mkdir -p "$(dirname "$DEST")"
  cp -R "$SRC" "$DEST"
done

# Handle dotfiles that are not under .config
DOTFILES=(
  ".zshrc"
  ".starship.toml"
)

for file in "${DOTFILES[@]}"; do
  SRC="$SCRIPT_DIR/.config/$file"
  DEST="$HOME/$file"

  if [[ ! -f "$SRC" ]]; then
    echo "⚠️  Skipping missing $SRC"
    continue
  fi

  if [[ -f "$DEST" ]]; then
    echo "📦 Backing up $DEST → ${DEST}_backup-$DATE"
    mv "$DEST" "${DEST}_backup-$DATE"
  fi

  echo "📂 Installing $file"
  cp "$SRC" "$DEST"
done

# Restart services
echo "🚀 Restarting services..."
skhd --restart-service || echo "⚠️ skhd restart failed"
yabai --restart-service || echo "⚠️ yabai restart failed"
brew services restart sketchybar || echo "⚠️ sketchybar restart failed"
brew services restart borders || echo "⚠️ borders restart failed"

echo "✅ Dotfiles applied successfully!"