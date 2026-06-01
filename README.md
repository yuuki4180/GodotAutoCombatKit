# Godot Auto Combat Kit

Godot Auto Combat Kit is an open-source Godot 4 reference project for building readable, touch-first mobile auto-combat games.

The project is intentionally small enough to study, but it already includes the core pieces of a vertical arena-action run builder: drag movement, keyboard testing controls, auto-targeting attacks, escalating enemy pressure, pickups, level-up choices, relic-style run modifiers, chests, altars, elites, and a guardian encounter.

The goal is not just to ship a game. The goal is to make a practical, inspectable Godot reference for developers who want to understand how mobile action-game systems fit together in one playable loop.

## Demo

Demo media is tracked in [issue #5](https://github.com/yuuki4180/GodotAutoCombatKit/issues/5). The capture guide is in [docs/demo_media.md](docs/demo_media.md).

## Why This Exists

Many Godot examples cover isolated mechanics. Godot Auto Combat Kit aims to be a practical reference for how those mechanics fit together in a phone-first action game loop:

- portrait mobile layout with desktop-friendly testing controls;
- readable auto-combat and nearest-target attack behavior;
- short-session wave pacing for 3 to 6 minute runs;
- run-only build growth through weapons, charms, and relics;
- event interruptions such as chests, pots, altars, elites, and a guardian;
- iOS export defaults that can be adapted by other Godot developers.

## Who This Helps

This project is intended for:

- Godot developers prototyping mobile action games;
- maintainers who want a compact example of touch-first combat architecture;
- contributors learning how run-based upgrade loops, pickups, and encounter pacing interact;
- developers who need a public-safe iOS export preset example.

See [docs/impact_and_maintenance.md](docs/impact_and_maintenance.md) for the project impact statement and maintainer plan.

## Current Prototype

- One playable Godot scene at `scenes/Main.tscn`.
- Main gameplay implementation in `scripts/main.gd`.
- Portrait viewport target of `720 x 1280`.
- Drag or WASD to move.
- Auto attacks target nearby enemies.
- Enemies drop XP, coins, relics, keys, ore, healing, and magnets.
- Level-ups offer weapon or charm choices.
- Chests, locked chests, pots, curse altars, elites, and a guardian add mid-run events.
- Extraction, carry-out loot, and permanent stash pressure are intentionally disabled for the current scope.

## Requirements

- Godot 4.6 or newer.
- macOS with Xcode only if you want to export the iOS preset.

## Run Locally

1. Install Godot 4.6 or newer.
2. Open this folder as a Godot project.
3. Run `scenes/Main.tscn`.

Desktop testing controls:

- `WASD`: move
- Mouse or touch drag: move toward the pointer
- `Space`: dash

## Public Repository Check

Before opening a pull request or publishing a release, run:

```sh
./tools/check_public_repo.sh
```

This checks required OSS files, confirms generated local directories are not tracked, and scans public files for common private signing identifiers.

## Repository Layout

```text
assets/                 Prototype sprites, icons, effects, and UI art.
docs/                   Design notes, roadmap, and maintainer docs.
scenes/Main.tscn        Main playable scene.
scripts/main.gd         Current gameplay prototype implementation.
tools/                  Maintainer checks for public repository hygiene.
project.godot           Godot project settings.
export_presets.cfg      Public-safe iOS export preset template.
```

## Project Status

Godot Auto Combat Kit is early-stage and playable, but it is not a finished game. The current goal is to make the prototype useful as an open-source reference for mobile-first Godot action-game implementation.

Current public baseline:

- MIT-licensed Godot project files and GDScript.
- Public-safe export preset with personal signing data removed.
- Contribution, security, issue, and pull request templates.
- Maintainer documentation and a roadmap.

Near-term work:

1. Split large gameplay systems out of `scripts/main.gd` into smaller Godot scripts.
2. Tune enemy waves, elite timing, and boss pressure around 3 to 6 minute runs.
3. Improve relic synergies and run-only economy clarity.
4. Add deterministic smoke checks for combat, pickups, and upgrade selection.
5. Polish iOS export documentation and touch joystick behavior.

See [docs/roadmap.md](docs/roadmap.md) for more detail.
See [docs/ios_export.md](docs/ios_export.md) for public-safe iOS export guidance.
See [docs/asset_policy.md](docs/asset_policy.md) for asset contribution and redistribution guidance.

Open issues for contributors:

- [Good first issues](https://github.com/yuuki4180/GodotAutoCombatKit/labels/good-first-issue)
- [Roadmap issues](https://github.com/yuuki4180/GodotAutoCombatKit/labels/roadmap)
- [Mobile readability tasks](https://github.com/yuuki4180/GodotAutoCombatKit/labels/mobile-readability)

## Maintainer Workflow

The project is maintained as a small OSS reference implementation:

- issues track reproducible bugs, roadmap tasks, and mobile-readability improvements;
- pull requests should include manual smoke-test notes;
- releases will summarize playable prototype milestones;
- security-sensitive reports should be handled privately through [SECURITY.md](SECURITY.md).

The intended Codex workflow is documented in [docs/codex_usage_plan.md](docs/codex_usage_plan.md).

## Testing

There is no automated Godot test suite yet. Manual smoke testing is documented in [docs/testing.md](docs/testing.md), and adding deterministic smoke checks is part of the near-term roadmap.

## Contributing

Contributions are welcome while the project is small and still easy to understand. Good first contributions include documentation, balance tuning notes, bug reports with reproduction steps, small readability refactors, and focused Godot 4 compatibility fixes.

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## Security

Please report security issues privately. See [SECURITY.md](SECURITY.md).

## License

Code and project files are licensed under the MIT License. See [LICENSE](LICENSE).

Artwork and generated game assets in `assets/` are included for use with this project. See [NOTICE.md](NOTICE.md) for asset notes.
