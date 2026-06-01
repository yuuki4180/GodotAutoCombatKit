# Architecture

Godot Auto Combat Kit is currently a single-scene Godot prototype. Most gameplay logic lives in `scripts/main.gd` so the full loop is easy to inspect in one file while the design is still moving quickly.

## Runtime Flow

1. `scenes/Main.tscn` loads the main script.
2. `_ready()` initializes textures, player state, UI, and run data.
3. `_process(delta)` advances the run loop.
4. Input handling updates the player's movement target.
5. Enemy spawning, elite timing, attacks, pickups, and event objects update each frame.
6. Draw and UI helpers render the portrait mobile view.

## Major Systems

- Player movement: touch or mouse drag first, WASD second.
- Combat: automatic attacks, projectile/effect lists, hit resolution, status effects.
- Progression: XP pickups, level-up choices, weapon levels, charm stat upgrades.
- Relics: run-only modifiers acquired from chests, altars, and events.
- Encounters: escalating waves, elites, chests, pots, altars, and guardian pressure.
- Presentation: sprite assets and draw helpers optimized for portrait readability.

## Refactor Direction

The next architecture step is to split stable behavior into focused scripts:

- `RunState`: player stats, timers, XP, coins, and run flags.
- `WeaponSystem`: weapon definitions, timers, projectiles, and upgrades.
- `RelicSystem`: relic definitions and triggered modifiers.
- `SpawnDirector`: enemy wave, elite, and guardian pacing.
- `PickupSystem`: loot spawning, collection, magnets, and rewards.
- `HudView`: panels, bars, choices, and mobile-safe layout.

Until that split happens, contributors should keep changes small and avoid moving unrelated systems in the same pull request.
