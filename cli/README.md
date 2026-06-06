# CLI Layer

This directory contains command implementations for Base Platform Tools.

Base owns `basectl` and `base-wrapper`. This repository owns optional tool
implementations that Base can orchestrate through `base_manifest.yaml`.

Use this layout:

```text
cli/
├── bash/
│   └── commands/
│       └── <tool>/
│           ├── <tool>.sh
│           ├── README.md
│           └── tests/
└── python/
    └── base_platform_tools/
        └── <tool>/
            ├── __init__.py
            ├── __main__.py
            ├── engine.py
            └── tests/
```

See `docs/cli-layout.md` for launcher and manifest conventions.
