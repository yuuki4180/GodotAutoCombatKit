#!/usr/bin/env sh
set -eu

required_files="
project.godot
scenes/Main.tscn
scripts/main.gd
README.md
LICENSE
CONTRIBUTING.md
SECURITY.md
docs/architecture.md
docs/asset_policy.md
docs/community_outreach.md
docs/codex_usage_plan.md
docs/demo_media.md
docs/impact_and_maintenance.md
docs/ios_export.md
docs/reviewer_summary.md
docs/testing.md
"

for path in $required_files; do
  if [ ! -f "$path" ]; then
    echo "Missing required file: $path" >&2
    exit 1
  fi
done

if git ls-files | grep -E '^(\.godot/|build/|tmp/|backups/)'; then
  echo "Generated or local-only directories are tracked." >&2
  exit 1
fi

if grep -R -E 'Apple Development:|Apple Distribution:|DEVELOPMENT_TEAM|PROVISIONING_PROFILE|66CMC28P94|4JNXTG2SYH|yuki4180|denso3150|icloud' \
  --exclude=check_public_repo.sh \
  --exclude-dir=.git \
  --exclude-dir=.godot \
  --exclude-dir=.godot-user \
  --exclude-dir=build \
  --exclude-dir=tmp \
  --exclude-dir=backups \
  .; then
  echo "Potential private signing or personal identifier found." >&2
  exit 1
fi

echo "Public repository checks passed."
