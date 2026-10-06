# `caff`

Caffeinate a named process by finding its PID and running macOS `caffeinate`
against that process.

Public invocation is exposed by the launcher at `bin/caff`; the implementation
lives here so command code, documentation, and tests stay together.

This utility was migrated from `basefoundry/base`. It belongs in Base Platform
Tools because it is a small operational helper, not part of Base's core
workspace orchestration surface.
