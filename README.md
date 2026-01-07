# GTA-Asset-Pack
GTA Asset Pack for Flipper Zero

![trevor](https://github.com/user-attachments/assets/737fe552-3d8d-409e-a326-b225aa4ad101)
![franklin](https://github.com/user-attachments/assets/a54c3451-cb68-441d-8f4e-527fdb9a75c8)
![michael](https://github.com/user-attachments/assets/22a55915-5b87-4fe0-a4c1-f165d0a767ee)
![waiting](https://github.com/user-attachments/assets/f5d02069-e2fe-4f70-9094-7a095aaccee7)
![subghz](https://github.com/user-attachments/assets/1ec3be27-f096-49c9-aadb-de7a39f1e4b4)
![saved](https://github.com/user-attachments/assets/0efe85da-9ece-4420-ae29-dff3bf23a55d)
![deleted](https://github.com/user-attachments/assets/dab8814e-8e44-4395-a138-005f2a9a31ff)
![ble](https://github.com/user-attachments/assets/cb2419e0-8c8e-4673-9cbd-86c7d247df6b)
![gta](https://github.com/user-attachments/assets/adfc52d9-f23c-4fb0-a3ca-fbf5dc1e44e3)
![trevor](https://github.com/user-attachments/assets/d1686459-faef-4378-b67b-3478201ed23a)
![michael](https://github.com/user-attachments/assets/a49be55e-9b42-4444-a4d7-fd935bdb0188)
![frenklin](https://github.com/user-attachments/assets/8a0d7f67-b061-4500-b3df-ba4258ea95a5)
![five](https://github.com/user-attachments/assets/86a06b1b-91d7-451f-80c0-153265dec473)

---

## CI Build & PR (Add assets to Flipper firmware) 🔧

This repository includes a GitHub Actions workflow that can:

- Create a branch in a target Flipper firmware repo, copy the `GTA/` assets into `assets/gta`, and commit the changes.
- Open a Pull Request automatically if you provide a personal access token (set secret `TARGET_PAT` in repository Settings → Secrets with `repo` scope).
- Run the firmware build (using the firmware `./fbt` tool) and upload build artifacts.

How to use:

1. Go to Actions → "Create PR & Build Flipper firmware with GTA assets" and click "Run workflow".
2. Inputs:
   - `target_repo`: owner/repo of the target firmware repo (default: `flipperdevices/flipperzero-firmware`)
   - `base_branch`: branch to target in the firmware repo (default: `dev`)
   - `pr_branch`: branch name to create (default: `add-gta-assets`)
   - `target_hw`: hardware target (default: `f7`)
3. If you want the workflow to push and create a PR in the target repo, add a repo-scoped PAT as a repository secret named `TARGET_PAT`.

Notes:

- Building in Actions may require additional toolchain configuration or secrets depending on the firmware repo; check the workflow logs if a build fails.
- If you want me to open the PR directly against the official firmware automatically, provide a PAT with repo permissions and I will adjust the workflow/branch name as needed.

