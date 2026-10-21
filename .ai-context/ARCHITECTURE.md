# Architecture

Public entrypoints in `bin/` are thin launchers. Bash implementations live under
`cli/bash/commands/<tool>/` alongside their README and BATS tests. The seeded
Python namespace is `cli/python/base_platform_tools/`; its presence is a layout
contract rather than evidence that a full Python utility suite exists.

`base_manifest.yaml` maps the caff, sort-in-place, cli-check, and validate
commands to repository-owned entrypoints. Base supplies `basectl` and
`base-wrapper`; do not duplicate them here. Python utilities should use the
shared wrapper with this repository's package path, and Bash utilities can
enter through the Base runtime.

Operational tools must keep data on stdout, diagnostics on stderr, and secret
values out of output/logs. Declare platform limitations explicitly rather than
pretending every OS supplies the same native utility. Keep tests close to the
individual command and common layout checks in `tests/validate.sh`.

Sources: [launcher conventions](../bin/README.md),
[Bash layout](../cli/bash/README.md), [Python layout](../cli/python/README.md),
[caff](../cli/bash/commands/caff/README.md), and
[sort-in-place](../cli/bash/commands/sort-in-place/README.md).
