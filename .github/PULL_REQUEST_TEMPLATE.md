## What does this PR do?

Adds the GTA Asset Pack (animations, fonts, icons) into the firmware assets directory so they can be embedded in builds.

## How to test

- The included GitHub Actions workflow `.github/workflows/create-pr-and-build.yml` can be dispatched manually to copy assets into the target firmware repo and run a build.

## Notes for maintainers

- The workflow requires a repository secret named `TARGET_PAT` (a personal access token with `repo` scope) if you want the job to push a branch and open a PR on the target firmware repository.
- If you prefer, the workflow will still run and produce build artifacts without creating a PR.

Please review placement of assets under `assets/gta` and adjust as needed (fonts and icons are placed under `assets/fonts` and `assets/icons`).
