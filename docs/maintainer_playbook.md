# Maintainer Playbook

## Review Priorities

1. Does the change preserve a playable run?
2. Does it improve mobile readability or maintainability?
3. Is the scope small enough to review safely?
4. Are export credentials, generated caches, and local files excluded?

## Manual Smoke Test

Run `scenes/Main.tscn` in Godot and check:

- player can move with WASD;
- player can move with touch or mouse drag;
- auto attacks fire at nearby enemies;
- enemies drop pickups;
- level-up choices appear;
- chests, altars, elites, or guardian events can appear during a run;
- restarting the run resets combat state.

## Release Notes Checklist

- Summarize gameplay changes.
- Call out compatibility changes for Godot versions.
- Mention any export preset changes.
- Include screenshots or a short gameplay clip for visual updates.

## Application Positioning

For open-source support programs, describe Dadasivive as:

> an open-source Godot 4 mobile action-game reference project focused on touch-first auto-combat, portrait readability, and maintainable survivor-like run-builder systems.
