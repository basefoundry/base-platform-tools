#!/usr/bin/env bash

require_file() {
    local path=$1

    if [[ ! -f "$path" ]]; then
        printf 'Missing required file: %s\n' "$path" >&2
        return 1
    fi

    return 0
}

require_executable() {
    local path=$1

    if [[ ! -x "$path" ]]; then
        printf 'Missing executable bit: %s\n' "$path" >&2
        return 1
    fi

    return 0
}

require_text() {
    local path=$1
    local pattern=$2

    if ! grep -Eq "$pattern" "$path"; then
        printf 'Missing expected text in %s: %s\n' "$path" "$pattern" >&2
        return 1
    fi

    return 0
}

main() {
    local repo_root
    repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)" || return 1
    cd "$repo_root" || return 1

    local failed=0

    require_file README.md || failed=1
    require_file bin/README.md || failed=1
    require_file CONTRIBUTING.md || failed=1
    require_file CHANGELOG.md || failed=1
    require_file LICENSE || failed=1
    require_file base_manifest.yaml || failed=1
    require_file cli/README.md || failed=1
    require_file cli/bash/README.md || failed=1
    require_file cli/python/README.md || failed=1
    require_file cli/python/base_platform_tools/__init__.py || failed=1
    require_file docs/cli-layout.md || failed=1
    require_file docs/tooling-boundary.md || failed=1
    require_file .github/workflows/tests.yml || failed=1
    require_file tests/validate.sh || failed=1
    require_executable tests/validate.sh || failed=1

    require_text base_manifest.yaml '^schema_version: 1$' || failed=1
    require_text base_manifest.yaml '^  name: base-platform-tools$' || failed=1
    require_text base_manifest.yaml '^  command: tests/validate\.sh$' || failed=1
    require_text base_manifest.yaml '^  cli-check: tests/validate\.sh$' || failed=1
    require_text README.md 'Base owns the workstation control plane' || failed=1
    require_text README.md 'CLI Layout' || failed=1
    require_text bin/README.md 'base-wrapper' || failed=1
    require_text cli/README.md 'Base owns `basectl`' || failed=1
    require_text cli/bash/README.md '#!/usr/bin/env basectl' || failed=1
    require_text cli/python/README.md 'base_platform_tools.<tool>' || failed=1
    require_text docs/cli-layout.md 'Do not copy `basectl` or `base-wrapper`' || failed=1
    require_text docs/cli-layout.md 'PYTHONPATH="\$repo_root/cli/python' || failed=1
    require_text docs/tooling-boundary.md 'Base is the workstation orchestration layer' || failed=1
    require_text docs/tooling-boundary.md 'Base Platform Tools does not own a second control plane' || failed=1
    require_text CONTRIBUTING.md 'Platform Support' || failed=1
    require_text CONTRIBUTING.md 'CLI Layout' || failed=1

    if [[ $failed -ne 0 ]]; then
        return 1
    fi

    printf 'Repository validation passed.\n'
    return 0
}

main "$@"
