#!/usr/bin/env bash
#
# Setup symlinks for Claude Code profiles and Cursor commands.
#
# Symlinks identical rules, settings, and commands into:
#   ~/.claude/        (personal profile)
#   ~/.claude-work/   (work profile)
#   ~/.cursor/        (Cursor IDE commands)
#
# Safe to run multiple times — removes stale symlinks before creating new ones.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

PROFILES=(
  "$HOME/.claude"
  "$HOME/.claude-work"
)

log() { printf '  %s\n' "$1"; }

link_file() {
  local src="$1"
  local dest="$2"

  # Remove existing symlink or file at destination
  if [ -L "$dest" ] || [ -f "$dest" ]; then
    rm -f "$dest"
  fi

  ln -sf "$src" "$dest"
  log "✓ $(basename "$dest") → $src"
}

echo ""
echo "Claude Code Profile Setup"
echo "========================="
echo ""
echo "Repository: $REPO_DIR"
echo ""

# --- Claude Code profiles ---
for profile_dir in "${PROFILES[@]}"; do
  profile_name="$(basename "$profile_dir")"

  echo "Profile: $profile_name"

  # Create the profile directory if it doesn't exist
  mkdir -p "$profile_dir"
  mkdir -p "$profile_dir/commands"

  # Symlink CLAUDE.md (global rules)
  link_file "$REPO_DIR/rules/claude-global-rules.md" "$profile_dir/CLAUDE.md"

  # Symlink settings.json
  link_file "$REPO_DIR/settings.json" "$profile_dir/settings.json"

  # Symlink each command namespace into the commands directory
  for ns_dir in "$REPO_DIR"/commands/*/; do
    if [ -d "$ns_dir" ]; then
      ns_name="$(basename "$ns_dir")"
      link_file "$ns_dir" "$profile_dir/commands/$ns_name"
    fi
  done

  echo ""
done

# --- Cursor IDE (optional) ---
echo "Cursor IDE:"
cursor_dir="$HOME/.cursor"
mkdir -p "$cursor_dir"

if [ -L "$cursor_dir/commands" ] || [ -d "$cursor_dir/commands" ]; then
  rm -rf "$cursor_dir/commands"
fi

ln -sf "$REPO_DIR/commands" "$cursor_dir/commands"
log "✓ commands → $REPO_DIR/commands"

echo ""
echo "Done. All profiles are linked."
echo ""
