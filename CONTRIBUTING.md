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
