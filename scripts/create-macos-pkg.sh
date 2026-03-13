#!/usr/bin/env bash
set -euo pipefail

APP_PATH="${1:-}"
APP_NAME="${2:-}"
BUNDLE_IDENTIFIER="${3:-}"
VERSION="${4:-}"
OUTPUT_PKG="${5:-}"

if [ -z "${APP_PATH}" ] || [ -z "${APP_NAME}" ] || [ -z "${BUNDLE_IDENTIFIER}" ] || [ -z "${VERSION}" ] || [ -z "${OUTPUT_PKG}" ]; then
  echo "Usage: create-macos-pkg.sh <app_path> <app_name> <bundle_identifier> <version> <output_pkg>"
  exit 1
fi

if [ ! -e "${APP_PATH}" ]; then
  echo "Build output not found: ${APP_PATH}"
  exit 1
fi

WORK_DIR="$(pwd)"
STAGING_DIR="${WORK_DIR}/pkg-staging"
PAYLOAD_DIR="${STAGING_DIR}/payload"
SCRIPTS_DIR="${STAGING_DIR}/scripts"

rm -rf "${STAGING_DIR}"
mkdir -p "${PAYLOAD_DIR}" "${SCRIPTS_DIR}"

SANITIZED_APP_NAME="$(echo "${APP_NAME}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"

if [ -d "${APP_PATH}" ] && [[ "${APP_PATH}" == *.app ]]; then
  mkdir -p "${PAYLOAD_DIR}/Applications"
  cp -R "${APP_PATH}" "${PAYLOAD_DIR}/Applications/"
elif [ -f "${APP_PATH}" ]; then
  mkdir -p "${PAYLOAD_DIR}/usr/local/bin"
  cp "${APP_PATH}" "${PAYLOAD_DIR}/usr/local/bin/${SANITIZED_APP_NAME}"
  chmod +x "${PAYLOAD_DIR}/usr/local/bin/${SANITIZED_APP_NAME}"
else
  echo "APP_PATH must be a .app directory or executable file: ${APP_PATH}"
  exit 1
fi

cat > "${SCRIPTS_DIR}/postinstall" <<'POSTINSTALL'
#!/usr/bin/env bash
set -euo pipefail

if command -v xattr >/dev/null 2>&1; then
  APP_GLOB="/Applications/*.app"
  for app in ${APP_GLOB}; do
    if [ -d "${app}" ]; then
      xattr -dr com.apple.quarantine "${app}" 2>/dev/null || true
    fi
  done
fi
POSTINSTALL

chmod +x "${SCRIPTS_DIR}/postinstall"

pkgbuild \
  --root "${PAYLOAD_DIR}" \
  --scripts "${SCRIPTS_DIR}" \
  --identifier "${BUNDLE_IDENTIFIER}" \
  --version "${VERSION}" \
  --install-location "/" \
  "${OUTPUT_PKG}"

echo "PKG generated: ${OUTPUT_PKG}"
