# Base Platform Tools

Base Platform Tools is the home for optional platform engineering, SRE,
infrastructure, cloud, monitoring, diagnostics, and operational utility CLIs
that can be used inside Base-managed workspaces.

This repository exists so the core Base product can stay focused on workstation
orchestration while platform-specific tools can evolve independently.

## Relationship To Base

Base owns the workstation control plane:

- project discovery
- setup, check, doctor, test, run, demo, and activation contracts
- manifest parsing and validation
- workspace and repository conventions
- cross-platform support for macOS, Linux, WSL, and eventually native Windows

Base Platform Tools owns optional utility commands that support platform,
infrastructure, SRE, cloud, monitoring, and operational workflows.

The boundary is intentional:

> Base orchestrates the workspace. Base Platform Tools provides optional tools
> that Base can orchestrate.

## Current Status

This repository is in its early stage. It has the initial CLI layout and hosts
the first migrated Bash utility CLIs from Base:

- `caff`
- `sort-in-place`

## Getting Started

Clone this repository next to Base:

```bash
git clone https://github.com/basefoundry/base-platform-tools.git
```

When Base is installed and the workspace is configured, this project should be
discoverable through:

```bash
basectl projects list
```

Run the repository validation directly:

```bash
tests/validate.sh
```

Or through Base:

```bash
basectl test base-platform-tools
```

List the commands declared by this repository:

```bash
basectl run base-platform-tools --list
```

Run the migrated utilities through Base:

```bash
basectl run base-platform-tools caff -- --help
basectl run base-platform-tools sort-in-place -- --help
```

## What Belongs Here

Good candidates for this repository include:

- cloud inventory and reporting tools
- Kubernetes and container platform diagnostics
- monitoring and alerting helpers
- incident-response utilities
- infrastructure drift checks
- platform runbook automation
- operational data collection tools

Each tool should have a clear operational purpose, documented platform support,
tests, and a manifest-declared command when it is ready for Base orchestration.

## What Does Not Belong Here

This repository should not become a generic script collection.

Keep these outside Base Platform Tools:

- Base core orchestration behavior
- project-specific application logic
- one-off personal scripts
- utilities without tests or a documented operational use case
- commands that require secret values to be printed, stored, or logged

## Repository Layout

```text
.
├── bin/
│   ├── README.md
│   ├── caff
│   └── sort-in-place
├── base_manifest.yaml
├── cli/
│   ├── README.md
│   ├── bash/
│   │   ├── README.md
│   │   └── commands/
│   │       ├── caff/
│   │       └── sort-in-place/
│   └── python/
│       ├── README.md
│       └── base_platform_tools/
│           └── __init__.py
├── docs/
│   ├── cli-layout.md
│   └── tooling-boundary.md
├── tests/
│   └── validate.sh
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

Future tools should live under the seeded CLI structure, with per-tool
subdirectories added when the first real tool is migrated or created.

See [CLI Layout](docs/cli-layout.md) for the command structure and launcher
conventions.

## License

Base Platform Tools is licensed under AGPL-3.0-or-later. See
[LICENSE](LICENSE) for the full terms.
