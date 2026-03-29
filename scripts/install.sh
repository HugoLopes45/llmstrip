#!/usr/bin/env sh
set -e

REPO="HugoLopes45/llmstrip"
BIN="llmstrip"

OS=$(uname -s)
ARCH=$(uname -m)

case "$OS" in
  Darwin)
    case "$ARCH" in
      arm64|aarch64) TARGET="aarch64-apple-darwin" ;;
      x86_64)        TARGET="x86_64-apple-darwin" ;;
      *) echo "Unsupported arch: $ARCH"; exit 1 ;;
    esac
    ;;
  Linux)
    case "$ARCH" in
      aarch64|arm64) TARGET="aarch64-unknown-linux-gnu" ;;
      x86_64)        TARGET="x86_64-unknown-linux-gnu" ;;
      *) echo "Unsupported arch: $ARCH"; exit 1 ;;
    esac
    ;;
  *)
    echo "Unsupported OS: $OS. Download manually from https://github.com/$REPO/releases/latest"
    exit 1
    ;;
esac

# Detect latest version (M1+L1 fix: guard empty VERSION)
VERSION=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
  | grep '"tag_name"' \
  | sed 's/.*"v\([^"]*\)".*/\1/')

if [ -z "$VERSION" ]; then
  echo "error: could not detect latest version. GitHub API may be rate-limited."
  echo "Install manually from https://github.com/$REPO/releases/latest"
  exit 1
fi

URL="https://github.com/$REPO/releases/download/v${VERSION}/${BIN}-v${VERSION}-${TARGET}.tar.gz"
# Note: no checksum verification — download is over HTTPS from GitHub.
# For supply-chain-sensitive environments, verify manually against release notes.

# M3 fix: extract to temp dir, not CWD
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "Installing $BIN $VERSION for $TARGET..."
curl -fsSL "$URL" | tar xz -C "$TMP"

# M2 fix: detect install prefix, fall back to ~/.local/bin for non-root
if [ -n "$DESTDIR" ]; then
  INSTALL_DIR="$DESTDIR"
elif [ "$(id -u)" = "0" ]; then
  INSTALL_DIR="/usr/local/bin"
else
  INSTALL_DIR="$HOME/.local/bin"
  mkdir -p "$INSTALL_DIR"
  echo "note: installing to $INSTALL_DIR (not root). Add it to PATH if needed."
fi

install -m755 "$TMP/$BIN" "$INSTALL_DIR/$BIN"
echo "Done. $BIN $VERSION installed to $INSTALL_DIR/$BIN"
echo "Run: $BIN --version"
