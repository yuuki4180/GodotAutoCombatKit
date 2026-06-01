# Roadmap

This roadmap is scoped around making Dadasivive a useful open-source Godot mobile action reference.

## Phase 1: Public OSS Baseline

- Public-safe repository metadata.
- License, contribution, security, and issue templates.
- Clear README and design notes.
- Redacted iOS export preset template.
- Basic CI checks for required project files and accidental signing identifiers.

## Phase 2: Maintainable Prototype

- Split high-churn logic out of `scripts/main.gd`.
- Add deterministic debug toggles for combat and upgrade testing.
- Document gameplay constants and tuning workflow.
- Add smoke-test scenes or scripts that can run in CI.

## Phase 3: Mobile Readability

- Improve pickup, enemy, and projectile contrast.
- Tune portrait UI spacing for small iPhone screens.
- Add clearer hit feedback and danger indicators.
- Polish touch joystick behavior.

## Phase 4: Run Builder Depth

- Improve weapon identity at level 1.
- Add clearer relic synergies.
- Tune elites, guardian timing, and chest/altar pacing.
- Keep run length around 3 to 6 minutes for the MVP target.

## Phase 5: Release Workflow

- Document iOS export setup without committing personal signing data.
- Add tagged prototype builds.
- Publish short gameplay clips and screenshots in the README.
- Maintain a small list of good first issues.
