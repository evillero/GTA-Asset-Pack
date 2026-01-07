CI Build & PR for Flipper firmware

This repo provides a workflow to help create a PR against a Flipper firmware repo and produce build artifacts.

What the workflow does

- Clones the target firmware repo (default: `flipperdevices/flipperzero-firmware`).
- Copies the `GTA/` folder into `assets/gta` and places fonts/icons into `assets/fonts` and `assets/icons`.
- Commits the changes on branch `add-gta-assets` (or your chosen `pr_branch`).
- If you add a repository secret named `TARGET_PAT` (a personal access token with `repo` scope), the workflow will push the branch and open a PR in the target repo.
- Attempts to build the firmware using `./fbt TARGET_HW=<target> fap_dist` and uploads build artifacts.

Security notes

- To allow automatic pushing and PR creation, create a secret named `TARGET_PAT` containing a PAT with `repo` scope. If you don't add this secret the workflow will still run and produce artifacts but won't push a branch or open a PR.

Customizing

- You can change the branch and base branch when you run the workflow.
- If the firmware build needs special secrets/toolchain configuration (seen in the official firmware CI), add them to this repository's Secrets and update the workflow accordingly.

Manual alternative

If you prefer not to give a PAT to the workflow, run `scripts/apply_and_commit_patch.sh firmware <branch>` locally after cloning `https://github.com/flipperdevices/flipperzero-firmware.git` and then push and open a PR manually.
