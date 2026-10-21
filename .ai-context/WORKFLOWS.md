# Workflows

After Base project setup and any required manifest-command trust review:

```bash
basectl run base-platform-tools --list
basectl run base-platform-tools caff -- --help
basectl run base-platform-tools sort-in-place -- --help
tests/validate.sh
bats cli/bash/commands/caff/tests/caff.bats
bats cli/bash/commands/sort-in-place/tests/sort-in-place.bats
```

`basectl test base-platform-tools` delegates to the manifest's validation
command. Use temporary copies when experimenting with in-place sorting.
The BATS suites cover the migrated commands; the baseline validator checks
repository layout, declarations, and documentation conventions.

Start from an issue, create a dedicated canonical worktree, and keep the PR
scoped to that issue. Include Summary, Issue, Validation, Platform Support, and
Notes in the PR. Documentation-only context changes have no runtime/platform
support change; tool changes must state their actual supported platforms.

Sources: [contribution guide](../CONTRIBUTING.md),
[repository validation](../tests/validate.sh), and [manifest](../base_manifest.yaml).
