# Python Tools

Python tools belong under the `base_platform_tools` package:

```text
cli/python/base_platform_tools/<tool>/
  __init__.py
  __main__.py
  engine.py
  tests/
```

Use package execution as the public Python contract:

```bash
base_platform_tools.<tool>
```

Thin launchers should set this repository's Python source root and then invoke
Base's wrapper:

```bash
PYTHONPATH="$repo_root/cli/python${PYTHONPATH:+:$PYTHONPATH}"
export PYTHONPATH

exec "$BASE_HOME/bin/base-wrapper" \
  --project "${BASE_PROJECT:-base-platform-tools}" \
  base_platform_tools.<tool> "$@"
```

The wrapper selects the `base-platform-tools` project virtual environment from
`~/.base.d/base-platform-tools/.venv` unless Base overrides
`BASE_PROJECT_VENV_DIR` for tests or project execution.

Python modules should keep import-time behavior cheap and side-effect free.
Command packages should expose a `main(argv) -> int` function and raise
`SystemExit(main())` from `__main__.py`.
