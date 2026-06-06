# Contributing To Base Platform Tools

Base Platform Tools is a developer tooling repository for optional platform,
SRE, infrastructure, cloud, monitoring, diagnostics, and operational utilities.

Contributions should keep the repository focused on tools that Base can
orchestrate without expanding Base core.

## Workflow

1. Start from a GitHub issue.
2. Create a dedicated worktree for each pull request.
3. Use a branch name in this format:

   ```text
   <category>/<issue>-<YYYYMMDD>-<slug>
   ```

   Example:

   ```text
   enhancement/42-20260606-kube-diagnostics
   ```

4. Keep each pull request scoped to one issue.
5. Include validation output in the pull request body.
6. Link the issue with a closing keyword such as `Closes #42`.

## Pull Request Template

Every pull request should cover:

- Summary
- Issue
- Validation
- Platform Support
- Notes

For tool changes, include the supported platforms explicitly. If a tool does not
support a platform, document why.

## Tool Standards

A tool belongs here only when it supports platform engineering, SRE,
infrastructure, cloud, monitoring, diagnostics, or operational workflows.

Each tool should:

- have a clear operational purpose
- avoid printing, storing, or logging secrets
- expose deterministic command behavior suitable for automation
- keep stdout reserved for command output
- send diagnostics to stderr
- provide tests for meaningful behavior
- document supported platforms
- fail clearly on unsupported platforms
- be callable through a manifest-declared Base command when appropriate

Prefer portable implementations when practical, but do not hide platform
limitations. A useful macOS/Linux/WSL-only tool is acceptable when the limitation
is explicit.

## CLI Layout

Use the seeded CLI layout for new tools:

- `bin/` contains thin public launchers only.
- `cli/bash/commands/<tool>/` contains Bash command implementations.
- `cli/python/base_platform_tools/<tool>/` contains Python command packages.
- `base_manifest.yaml` declares commands that Base can run with
  `basectl run base-platform-tools <command>`.

Do not copy `basectl` or `base-wrapper` into this repository. Base owns those
entrypoints. Base Platform Tools reuses them through manifest-declared commands
and thin launchers.

Python launchers should invoke:

```bash
"$BASE_HOME/bin/base-wrapper" \
  --project "${BASE_PROJECT:-base-platform-tools}" \
  base_platform_tools.<tool> "$@"
```

When a Python launcher needs this repository's package root, prepend
`$repo_root/cli/python` to `PYTHONPATH` before calling `base-wrapper`.

Bash tools that need the Base runtime may use:

```bash
#!/usr/bin/env basectl
```

and should keep their implementation under `cli/bash/commands/<tool>/`.

## Validation

Run:

```bash
tests/validate.sh
```

When working from a Base-managed workspace, also run:

```bash
basectl test base-platform-tools
```

Use more specific tests once real tool implementations are added.

For migrated Bash tools, run the BATS coverage:

```bash
bats cli/bash/commands/caff/tests/caff.bats
bats cli/bash/commands/sort-in-place/tests/sort-in-place.bats
```
