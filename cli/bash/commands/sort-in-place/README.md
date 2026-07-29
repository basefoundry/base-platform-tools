# `sort-in-place`

Sort one or more text files in place, optionally with `sort -u` behavior.

Public invocation is exposed by the launcher at `bin/sort-in-place`; the
implementation lives here so command code, documentation, and tests stay
together.

This utility was migrated from `basefoundry/base`. It belongs in Base Platform
Tools because it is a small operational helper, not part of Base's core
workspace orchestration surface.
