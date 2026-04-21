#!/usr/bin/env bash
# Downloads Obsidian community plugin binaries into this directory.
# Run once per host after symlinking .obsidian:
#   bash ~/Code/opensource/dotfiles/obsidian/install-plugins.sh
#
# Reads community-plugins.json for the list of enabled plugins and
# each plugin's manifest.json for the target version. Fetches
# main.js, manifest.json, and styles.css from the plugin's GitHub release.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGINS_DIR="$SCRIPT_DIR/plugins"
REGISTRY_URL="https://raw.githubusercontent.com/obsidianmd/obsidian-releases/HEAD/community-plugins.json"

echo "Fetching community plugins registry..."
registry=$(curl -fsSL "$REGISTRY_URL")

IFS=$'\n' read -r -d '' -a plugin_ids < <(python3 -c "
import json
ids = json.load(open('$SCRIPT_DIR/community-plugins.json'))
print('\n'.join(ids))
" && printf '\0') || true

for id in "${plugin_ids[@]}"; do
  plugin_dir="$PLUGINS_DIR/$id"
  manifest="$plugin_dir/manifest.json"

  # Resolve GitHub repo from registry
  repo=$(echo "$registry" | python3 -c "
import json, sys
plugins = json.load(sys.stdin)
match = next((p for p in plugins if p['id'] == '$id'), None)
if match:
    print(match['repo'])
" 2>/dev/null)

  if [[ -z "$repo" ]]; then
    echo "  [$id] not found in registry, skipping"
    continue
  fi

  # Determine version: use pinned manifest if present, else latest release
  if [[ -f "$manifest" ]]; then
    version=$(python3 -c "import json; print(json.load(open('$manifest'))['version'])")
    echo "  [$id] installing pinned v$version from $repo"
  else
    version=$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest" \
      | python3 -c "import json,sys; print(json.load(sys.stdin)['tag_name'])")
    echo "  [$id] installing latest v$version from $repo"
  fi

  mkdir -p "$plugin_dir"
  base="https://github.com/$repo/releases/download/$version"

  for file in main.js manifest.json styles.css; do
    url="$base/$file"
    dest="$plugin_dir/$file"
    if curl -fsSL --head "$url" >/dev/null 2>&1; then
      curl -fsSL "$url" -o "$dest"
    fi
  done

  echo "  [$id] done"
done

echo "All plugins installed."
