BASE_PLATFORM_TOOLS_REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"

bpt_setup_test_tmpdir() {
    TEST_TMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/base-platform-tools-test.XXXXXX")"
}

bpt_teardown_test_tmpdir() {
    if [[ -n "${TEST_TMPDIR:-}" && -d "$TEST_TMPDIR" ]]; then
        rm -rf "$TEST_TMPDIR"
    fi
}
