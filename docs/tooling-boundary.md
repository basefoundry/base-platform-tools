# Tooling Boundary

Base Platform Tools exists to keep optional infrastructure and operations
utilities separate from Base core.

## Core Principle

Base is the workstation orchestration layer. Base Platform Tools is an optional
tooling layer that Base can orchestrate.

This means:

- Base should remain small, portable, and cross-platform.
- Tools should live here when they are useful but not required for Base itself.
- Projects should declare tool usage through their own Base manifests when the
  tool is part of that project's workflow.

## Base Owns

Base owns behavior that is required to manage a developer workstation and its
participating project repositories:

- bootstrap and setup orchestration
- project discovery
- project manifests
- check, doctor, test, run, demo, and activate contracts
- shell and profile integration
- repo baseline conventions
- cross-platform substrate support

## Base Platform Tools Owns

Base Platform Tools owns optional commands in the platform engineering and
operations space:

- cloud management helpers
- cloud inventory and reporting tools
- Kubernetes and container diagnostics
- monitoring and alerting helpers
- incident-response commands
- infrastructure drift checks
- runbook automation
- platform diagnostics and reporting

These tools may have different platform support than Base itself.

## CLI Boundary

Base Platform Tools does not own a second control plane. It must not copy
`basectl` or `base-wrapper`.

Instead:

- Base owns `basectl`.
- Base owns `base-wrapper`.
- Base Platform Tools owns optional tool implementations.
- `base_manifest.yaml` declares runnable tool commands.
- Base invokes those commands through `basectl run base-platform-tools <command>`.

Bash tools may use the Base runtime through `#!/usr/bin/env basectl`. Python
tools should run through Base's `base-wrapper` using the `base-platform-tools`
project virtual environment.

## Platform Support Policy

Base should aim for macOS, Linux, WSL, and eventually native Windows support.

Tools in this repository may support a narrower set of platforms when they have
honest reasons to do so. Each tool should document its supported platforms and
fail clearly when invoked on an unsupported platform.

Recommended support labels:

- `macos`
- `linux`
- `wsl`
- `windows`

Unsupported platforms should include a short reason.

## Migration Policy

The initial migrated utilities are `caff` and `sort-in-place`, which came from
`codeforester/base`.

When a utility moves here:

1. Open a dedicated issue.
2. Move the implementation and tests.
3. Add or update documentation.
4. Add a manifest-declared command when appropriate.
5. Decide whether Base needs a temporary compatibility note or shim.
6. Update Base documentation to point to this repository.

Do not migrate tools opportunistically in unrelated changes.

## Admission Checklist

A new tool is a good fit when it answers yes to most of these:

| Question | Expected answer |
| --- | --- |
| Does it support platform, infrastructure, SRE, cloud, monitoring, diagnostics, or operations work? | Yes |
| Is it useful across more than one project? | Yes |
| Can it be tested locally or with a deterministic fixture? | Yes |
| Can it avoid printing or storing secrets? | Yes |
| Can it declare supported platforms clearly? | Yes |
| Is it outside Base's workstation orchestration responsibility? | Yes |

If the answer is no, the tool probably belongs in a project repository or in
Base core, depending on the behavior.
