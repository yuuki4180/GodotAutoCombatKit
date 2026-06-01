# Security Policy

## Supported Versions

Dadasivive is an early-stage prototype. Security fixes are handled on the `main` branch.

## Reporting A Vulnerability

Please do not open a public issue for security-sensitive reports.

Report privately by contacting the maintainer through the GitHub repository owner profile. Include:

- affected commit or release;
- reproduction steps;
- expected and actual impact;
- any relevant logs, files, or screenshots.

The maintainer will acknowledge the report, investigate the issue, and publish a fix or advisory when appropriate.

## Scope

Relevant reports include:

- unsafe handling of local files or user data;
- accidental inclusion of signing credentials or secrets;
- platform export configuration that could expose private identifiers;
- dependency or tooling issues that affect contributors.
