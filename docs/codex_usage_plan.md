# Codex Usage Plan

Dadasivive will use Codex for core open-source maintenance work, not for closed-source product development.

## Pull Request Review

Codex can help review changes to:

- GDScript gameplay systems;
- Godot scenes and project settings;
- mobile input behavior;
- asset references;
- iOS export configuration;
- documentation and contributor workflows.

Expected output:

- focused review comments;
- likely regression points;
- missing manual smoke tests;
- suggested minimal fixes.

## Issue Triage

Codex can help turn vague bug reports into actionable maintainer work:

- identify missing reproduction details;
- map symptoms to likely systems in `scripts/main.gd`;
- suggest debug steps;
- draft issue labels and follow-up questions;
- identify whether the bug affects desktop testing, mobile input, combat, pickups, UI, or export configuration.

## Regression Hunting

The prototype currently has many systems in one large script. Codex can reduce review load by tracing interactions between:

- player stats and upgrade choices;
- weapon timers and projectile state;
- enemy wave pacing and elite timing;
- pickups, magnets, chest rewards, and relic effects;
- UI panels and run-state flags.

## Release Workflow

Codex can help draft:

- release notes;
- upgrade notes for Godot versions;
- checklist summaries;
- risk notes for testers;
- documentation updates after feature changes.

## Automation Targets

Near-term automation should focus on low-risk, maintainer-friendly checks:

- required project files exist;
- ignored directories are not committed;
- personal signing identifiers are absent from public export presets;
- documentation links remain valid;
- manual smoke-test checklist is updated when gameplay systems change.
