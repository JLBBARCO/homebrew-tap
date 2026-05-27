# homebrew-tap

Shared base repository for macOS installer and Homebrew release automation across multiple projects.

Use this repo as the central place for:

- Reusable macOS installer packaging logic
- Homebrew formula bump automation after releases
- Workflow templates that downstream repositories can copy and customize
- A reusable Homebrew bump workflow that downstream repositories can call directly

## What is included

- Reusable workflow: .github/workflows/reusable-macos-installer.yml
- Reusable workflow: .github/workflows/reusable-homebrew-bump-formula.yml
- PKG packaging script: scripts/create-macos-pkg.sh
- Integration templates:
  - templates/passwords-manager-macos-installer.yml
  - templates/auto-install-programs-macos-installer.yml
  - templates/homebrew-bump-formula.yml

## How to reuse in a project repo

1. Copy the matching installer template into `.github/workflows/macos-installer.yml`.
2. Point the workflow to this repository's reusable workflow:

   uses: JLBBARCO/homebrew-tap/.github/workflows/reusable-macos-installer.yml@main

3. Make sure the build produces the `.app` or executable defined in `app_path`.
4. Copy `templates/homebrew-bump-formula.yml` if the project also publishes Releases and needs to update a Homebrew tap.
5. Set the required repository variables and the `COMMITTER_TOKEN` secret in the project repo.

## Result

Each downstream repo can reuse the same packaging and Homebrew bump flow without duplicating the core logic.

If the project publishes GitHub Releases, use `softprops/action-gh-release` in that project repo and then run `templates/homebrew-bump-formula.yml` there. The template now calls the reusable workflow in this repository, so downstream repos only keep a tiny release trigger while this repo owns the bump logic and SHA-256 handling.

Set the repository variables `HOMEBREW_FORMULA_NAME`, `HOMEBREW_FORMULA_PATH`, and `HOMEBREW_TAP_REPO` in each project repo, plus `HOMEBREW_BASE_BRANCH` if the tap does not use `main`. The workflow also needs a `COMMITTER_TOKEN` secret with write access to the tap.
