# Bash Tools

Bash tools belong under:

```text
cli/bash/commands/<tool>/<tool>.sh
```

When a Bash tool needs the Base runtime, use:

```bash
#!/usr/bin/env basectl

main() {
    ...
}

main "$@"
```

Expose runnable Bash tools through `base_manifest.yaml`:

```yaml
commands:
  example: cli/bash/commands/example/example.sh
```

Keep Bash tools focused on shell-native orchestration. Move structured parsing,
state modeling, and non-trivial data transformations into Python unless shell is
clearly the better substrate.
