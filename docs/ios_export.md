# iOS Export Guide

Godot Auto Combat Kit includes a public-safe iOS export preset so contributors can inspect the expected mobile export shape without exposing private Apple signing data.

## Public Preset Rules

The committed `export_presets.cfg` must not contain:

- Apple Team IDs;
- personal code signing identities;
- provisioning profile UUIDs;
- private bundle identifiers;
- generated Xcode build output.

Keep local signing details in your own Godot editor settings or local export workflow. Do not commit them.

## Local Setup

1. Open the project in Godot 4.6 or newer.
2. Open `Project > Export`.
3. Select the iOS preset.
4. Set your own Apple Team ID.
5. Set your own bundle identifier.
6. Select your local provisioning profile and signing identity.
7. Export locally.

## Before Opening A Pull Request

Run:

```sh
./tools/check_public_repo.sh
```

Then confirm:

- `export_presets.cfg` still uses placeholder signing values;
- generated `build/` output is not staged;
- no personal Apple identifiers are present in public files.

## Why This Matters

Mobile export configuration is a common source of accidental secret exposure in Godot projects. Keeping a clean public preset makes this repository safer for contributors and more useful as a reference.
