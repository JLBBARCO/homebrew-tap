# homebrew-tap

Central system to generate macOS (.pkg) installers for:

- jlbbarco/passwords-manager
- jlbbarco/auto-install-programs

## What was added

- Reusable workflow: .github/workflows/reusable-macos-installer.yml
- PKG packaging script: scripts/create-macos-pkg.sh
- Integration templates:
  - templates/passwords-manager-macos-installer.yml
  - templates/auto-install-programs-macos-installer.yml

## How to use in each repository

1. Copy the corresponding template to `.github/workflows/macos-installer.yml` in the target repository.
2. Adjust the reusable workflow reference branch/tag if needed:

   uses: JLBBARCO/homebrew-tap/.github/workflows/reusable-macos-installer.yml@main

3. Make sure the build generates a `.app` at the path defined in `app_path`.
4. Publish a `vX.Y.Z` tag or run it via `workflow_dispatch`.

## Result

Each run generates a `.pkg` artifact ready for download in GitHub Actions.

If you want to publish it automatically to a Release, add a step in each project workflow to attach `${{ inputs.artifact_name }}` using `actions/create-release` or `softprops/action-gh-release`.
