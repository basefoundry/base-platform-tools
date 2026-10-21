# Base Platform Tools

This repository owns optional utility CLIs for platform engineering, SRE,
infrastructure, diagnostics, and operational work. Its current implemented
utilities are `caff` and `sort-in-place`; broader cloud, Kubernetes, monitoring,
and incident-response utilities are possible additions, not an existing catalog.

Base owns workspace discovery, setup, trust, manifest interpretation, and command
orchestration. This repository owns utility behavior, platform-specific handling,
and utility tests. It must not become another workstation control plane or a
collection of untested one-off scripts.

`caff` locates a named process and uses macOS `caffeinate` to keep it awake.
`sort-in-place` sorts text files, optionally removing duplicate lines. The
former is macOS-specific; the latter mutates its selected input files. Consult
each command's help and tests before proposing cross-platform behavior.

Sources: [README](../README.md), [tooling boundary](../docs/tooling-boundary.md),
[manifest](../base_manifest.yaml), and [CLI layout](../docs/cli-layout.md).
