#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-or-later
set -euo pipefail

TOOL_NAME="openssl"
BINARY_NAME="openssl"

fail() { echo -e "\e[31mFail:\e[m $*" >&2; exit 1; }

list_all_versions() {
  local curl_opts=(-sL)
  [[ -n "${GITHUB_TOKEN:-}" ]] && curl_opts+=(-H "Authorization: token $GITHUB_TOKEN")
  curl "${curl_opts[@]}" "https://api.github.com/repos/openssl/openssl/tags" 2>/dev/null | \
    grep -o '"name": "openssl-[^"]*"' | sed 's/"name": "openssl-//' | sed 's/"$//' | sort -V
}

download_release() {
  local version="$1" download_path="$2"
  local url="https://github.com/openssl/openssl/releases/download/openssl-${version}/openssl-${version}.tar.gz"

  echo "Downloading OpenSSL $version..."
  mkdir -p "$download_path"
  curl -fsSL "$url" -o "$download_path/openssl.tar.gz" || fail "Download failed"
  tar -xzf "$download_path/openssl.tar.gz" -C "$download_path" --strip-components=1
  rm -f "$download_path/openssl.tar.gz"
}

install_version() {
  local install_type="$1" version="$2" install_path="$3"

  cd "$ASDF_DOWNLOAD_PATH"
  ./Configure --prefix="$install_path" --openssldir="$install_path/ssl" || fail "Configure failed"
  make -j"$(nproc)" || fail "Build failed"
  make install_sw || fail "Install failed"
}
