#!/usr/bin/env bash
# bump-cask.sh <version> — rewrite Casks/spectroscope.rb for a fresh release.
# Reads the sha256 from the GitHub release asset's own digest, so the cask
# can never carry a hash that disagrees with what users download.
set -euo pipefail
V="${1:?usage: bump-cask.sh <version, e.g. 0.4.2>}"
DIGEST="$(gh api "repos/spectroscope/spectroscope/releases/tags/v${V}" \
  --jq '.assets[] | select(.name == "spectroscope-'"${V}"'-arm64.dmg") | .digest')"
SHA="${DIGEST#sha256:}"
[ -n "$SHA" ] || { echo "no dmg digest on release v${V}" >&2; exit 1; }
CASK="$(dirname "$0")/../Casks/spectroscope.rb"
sed -i '' -e "s/^  version \".*\"/  version \"${V}\"/" \
          -e "s/^  sha256 \".*\"/  sha256 \"${SHA}\"/" "$CASK"
echo "bumped to ${V} (${SHA}) — audit, commit, push"
