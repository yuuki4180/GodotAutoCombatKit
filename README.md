# Dadasivive

Dadasivive is an open-source Godot 4 mobile action prototype for building readable, touch-first survivor-like games.

The project is intentionally small enough to study, but it already includes the core pieces of a vertical auto-combat run builder: drag movement, keyboard testing controls, auto-targeting attacks, escalating enemy pressure, pickups, level-up choices, relic-style run modifiers, chests, altars, elites, and a guardian encounter.

## Why This Exists

Many Godot examples cover isolated mechanics. Dadasivive aims to be a practical reference for how those mechanics fit together in a phone-first action game loop:

- portrait mobile layout with desktop-friendly testing controls;
- readable auto-combat and nearest-target attack behavior;
- short-session wave pacing for 3 to 6 minute runs;
- run-only build growth through weapons, charms, and relics;
- event interruptions such as chests, pots, altars, elites, and a guardian;
- iOS export defaults that can be adapted by other Godot developers.

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

## Repository Layout

```text
assets/                 Game sprites, icons, effects, and UI art.
docs/                   Design notes, roadmap, and maintainer docs.
scenes/Main.tscn        Main playable scene.
scripts/main.gd         Current gameplay prototype implementation.
project.godot           Godot project settings.
export_presets.cfg      Public-safe iOS export preset template.
```

## Project Status

Dadasivive is early-stage and playable, but it is not a finished game. The current goal is to make the prototype useful as an open-source reference for mobile-first Godot action-game implementation.

Near-term work:

1. Split large gameplay systems out of `scripts/main.gd` into smaller Godot scripts.
2. Tune enemy waves, elite timing, and boss pressure around 3 to 6 minute runs.
3. Improve relic synergies and run-only economy clarity.
4. Add deterministic smoke checks for combat, pickups, and upgrade selection.
5. Polish iOS export documentation and touch joystick behavior.

See [docs/roadmap.md](docs/roadmap.md) for more detail.

## Contributing

Contributions are welcome while the project is small and still easy to understand. Good first contributions include documentation, balance tuning notes, bug reports with reproduction steps, small readability refactors, and focused Godot 4 compatibility fixes.

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## Security

Please report security issues privately. See [SECURITY.md](SECURITY.md).

## License

Code and project files are licensed under the MIT License. See [LICENSE](LICENSE).

Artwork and generated game assets in `assets/` are included for use with this project. See [NOTICE.md](NOTICE.md) for asset notes.
