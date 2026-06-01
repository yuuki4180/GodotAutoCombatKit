# Impact And Maintenance

This document explains why Dadasivive is being maintained as open source and how it should grow.

## Ecosystem Importance

Dadasivive targets a practical gap in Godot learning material: full-loop, mobile-first action-game prototypes are harder to study than isolated examples. The project provides an inspectable reference for:

- portrait mobile layout and touch-first control decisions;
- readable auto-combat behavior;
- short-session run pacing;
- pickup, upgrade, relic, and encounter systems;
- iOS export setup without committing personal signing data.

The repository is early-stage and does not yet claim broad adoption. Its value is that it is a runnable, permissively licensed, focused reference for a type of mobile game loop that many small Godot developers try to build from scratch.

## Maintenance Signals

The repository includes:

- MIT license;
- public README with setup instructions;
- contribution guide;
- security policy;
- issue templates;
- pull request template;
- roadmap;
- architecture notes;
- maintainer playbook;
- public-safe export preset.

## Maintainer Responsibilities

The primary maintainer is responsible for:

- triaging bug reports and feature requests;
- reviewing pull requests for scope and playable behavior;
- keeping the project runnable on supported Godot versions;
- preserving public-safe export configuration;
- documenting releases and roadmap decisions;
- improving code structure as the prototype stabilizes.

## What Good Contributions Look Like

The highest-value contributions are small and verifiable:

- a reproducible gameplay bug with clear steps;
- a focused balance tuning change with before/after notes;
- a mobile readability improvement with screenshots or video;
- a Godot compatibility fix;
- a documentation improvement that helps new contributors run or inspect the project.

## Why Codex Helps

Codex is useful here because the project has many maintenance tasks that require reading across gameplay state, UI, assets, export configuration, and docs. Good Codex-assisted workflows include regression hunting, pull request review, issue reproduction, release note drafting, and documentation checks.
