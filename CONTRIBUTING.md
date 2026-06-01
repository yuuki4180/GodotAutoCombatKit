# Contributing

Thanks for helping improve Godot Auto Combat Kit. The project is currently a compact Godot 4 prototype, so the highest-value contributions are focused, easy to review, and tied to playable behavior.

## Good First Contributions

- Reproduce and document gameplay bugs.
- Improve README or design documentation.
- Tune simple balance values with before/after notes.
- Fix Godot 4 compatibility warnings.
- Improve mobile readability for pickups, enemy silhouettes, hit effects, or UI.
- Split small, self-contained helpers out of `scripts/main.gd` without changing behavior.

## Good First Contribution Workflow

1. Pick an issue labeled [`good-first-issue`](https://github.com/yuuki4180/GodotAutoCombatKit/labels/good-first-issue).
2. Comment on the issue with the change you plan to make.
3. Keep the first pull request small.
4. Run `./tools/check_public_repo.sh` before opening the pull request.
5. Include manual smoke-test notes from [docs/testing.md](docs/testing.md).
6. Add screenshots or short clips for visual changes.

## Development Setup

1. Install Godot 4.6 or newer.
2. Open the repository folder in Godot.
3. Run `scenes/Main.tscn`.
4. Test with touch drag or mouse drag, plus WASD for desktop movement checks.

## Pull Request Guidelines

- Keep pull requests small and focused.
- Include reproduction steps for bug fixes.
- Include screenshots or short clips for visual changes when possible.
- Explain any balance changes in concrete terms.
- Avoid broad rewrites unless there is an issue discussing the intended structure.
- Do not commit personal export credentials, signing identities, or platform-specific secrets.
- For asset changes, follow [docs/asset_policy.md](docs/asset_policy.md).

## Coding Style

- Prefer clear GDScript over clever abstractions.
- Keep gameplay constants named and easy to tune.
- Keep mobile readability in mind: effects should be obvious on a portrait phone screen.
- Add comments only where the behavior is not obvious from the code.

## Issue Triage

Bug reports should include:

- Godot version.
- Platform and device.
- Steps to reproduce.
- Expected behavior.
- Actual behavior.
- Screenshot, video, or log output if relevant.
