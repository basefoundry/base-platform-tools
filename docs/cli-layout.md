# CLI Layout

Base Platform Tools provides optional tool implementations for Base-managed
workspaces. It reuses Base for orchestration and Python environment selection.

Do not copy `basectl` or `base-wrapper` into this repository.

## Ownership

| Concern | Owner |
| --- | --- |
| Workspace orchestration | Base |
| `basectl` control plane | Base |
| `base-wrapper` Python execution wrapper | Base |
| Optional platform tools | Base Platform Tools |
| Tool command declarations | `base_manifest.yaml` in this repository |

## Directory Structure

```text
bin/
  <tool>                         # optional thin launchers

cli/
  bash/
    commands/
      <tool>/
        <tool>.sh
        README.md
        tests/

  python/
    base_platform_tools/
      <tool>/
        __init__.py
        __main__.py
        engine.py
        tests/
```

Create only the directories that a real tool needs. The top-level scaffold
exists to make the expected shape clear before production tools are added.

## Manifest Commands

Expose tools through `base_manifest.yaml` so Base can list and run them:

```yaml
commands:
  example-bash: cli/bash/commands/example-bash/example-bash.sh
  example-python: bin/example-python
```

Run them with:

```bash
basectl run base-platform-tools example-bash
basectl run base-platform-tools example-python
```

Use `--` to pass tool-specific arguments:

```bash
basectl run base-platform-tools example-python -- --format json
```

## Bash Tools

Bash tools that need the Base runtime should use:

```bash
#!/usr/bin/env basectl

main() {
    ...
}

main "$@"
```

The command implementation should live under:

```text
cli/bash/commands/<tool>/<tool>.sh
```

Prefer Bash for shell-native orchestration and small wrappers. Prefer Python
for structured parsing, data modeling, provider clients, reporting, and logic
that needs focused unit tests.

## Python Tools

Python tools should run as packages under `base_platform_tools`:

```text
cli/python/base_platform_tools/<tool>/
  __init__.py
  __main__.py
  engine.py
```

Use this launcher shape when a Python tool needs a public executable:

```bash
#!/usr/bin/env bash

repo_root="$(cd "$(dirname "$0")/.." && pwd -P)" || exit 1

: "${BASE_HOME:?BASE_HOME is required. Run through basectl run or basectl activate.}"

PYTHONPATH="$repo_root/cli/python${PYTHONPATH:+:$PYTHONPATH}"
export PYTHONPATH

exec "$BASE_HOME/bin/base-wrapper" \
  --project "${BASE_PROJECT:-base-platform-tools}" \
  base_platform_tools.<tool> "$@"
```

This does two things:

1. Adds this repository's `cli/python` directory to `PYTHONPATH`.
2. Delegates interpreter selection to Base's `base-wrapper`, using the
   `base-platform-tools` project virtual environment.

Base's wrapper adds Base's own Python libraries. The launcher adds this
repository's Python package root.

## Tests

Each tool should have focused tests near the implementation:

```text
cli/bash/commands/<tool>/tests/
cli/python/base_platform_tools/<tool>/tests/
```

Wire the useful test command into `base_manifest.yaml` when the tool is ready.
The repository-level `tests/validate.sh` should stay a lightweight contract
check for the whole repo.
