# homebrew-tap

Sistema central para gerar instaladores macOS (.pkg) para:

- jlbbarco/passwords-manager
- jlbbarco/auto-install-programs

## O que foi adicionado

- Workflow reutilizavel: .github/workflows/reusable-macos-installer.yml
- Script de empacotamento PKG: scripts/create-macos-pkg.sh
- Templates de integracao:
  - templates/passwords-manager-macos-installer.yml
  - templates/auto-install-programs-macos-installer.yml

## Como usar em cada repositorio

1. Copie o template correspondente para `.github/workflows/macos-installer.yml` no repositorio de destino.
2. Ajuste branch/tag de referencia do reusable workflow, se necessario:

   uses: JLBBARCO/homebrew-tap/.github/workflows/reusable-macos-installer.yml@main

3. Garanta que o build gera um `.app` no caminho informado em `app_path`.
4. Publique uma tag `vX.Y.Z` ou execute via `workflow_dispatch`.

## Resultado

Cada execucao gera um artefato `.pkg` pronto para download no GitHub Actions.

Se quiser publicar automaticamente em Release, adicione uma etapa no workflow de cada projeto para anexar `${{ inputs.artifact_name }}` em `actions/create-release` ou `softprops/action-gh-release`.
