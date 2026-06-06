# Public Launchers

This directory is reserved for thin public launcher scripts.

Base Platform Tools does not provide its own `basectl` or `base-wrapper`.
Launchers in this directory should delegate through the Base installation that
is already managing the workspace.

## Python Launcher Pattern

Use this shape for a Python tool when a public executable is useful:

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

The launcher stays small. The behavior belongs under
`cli/python/base_platform_tools/<tool>/`.

## Bash Launcher Pattern

Most Bash tools can be exposed directly through `base_manifest.yaml` without a
public launcher. If a public launcher is useful, keep it small and delegate to
the implementation under `cli/bash/commands/<tool>/`.
