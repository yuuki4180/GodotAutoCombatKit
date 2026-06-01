# Testing

Dadasivive does not yet have an automated Godot test suite. Until deterministic smoke checks are added, maintainers and contributors should use this manual checklist.

## Manual Smoke Test

Open the project in Godot 4.6 or newer and run `scenes/Main.tscn`.

Check:

- the scene starts without missing-resource errors;
- the player can move with WASD;
- the player can move with mouse drag or touch drag;
- auto attacks fire at nearby enemies;
- enemies can take damage and drop pickups;
- XP can trigger a level-up choice;
- weapon or charm choices can be selected;
- chests, pots, altars, elites, or guardian events can appear during a run;
- restarting the run resets player, enemy, projectile, loot, and UI state.

## iOS Export Check

Before exporting:

- set your own Apple Team ID locally;
- set your own bundle identifier locally;
- do not commit personal signing identities;
- keep public export presets free of credentials.

## Documentation Check

When changing gameplay behavior, update at least one of:

- [README.md](../README.md);
- [docs/game_design.md](game_design.md);
- [docs/architecture.md](architecture.md);
- [docs/roadmap.md](roadmap.md).

## Future Automated Checks

Planned checks:

- static file presence check;
- public export preset secret scan;
- GDScript syntax check in headless Godot;
- deterministic combat smoke scene;
- deterministic pickup and upgrade smoke scene.
