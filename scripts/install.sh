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

VERSION=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
URL="https://github.com/$REPO/releases/download/v${VERSION}/${BIN}-v${VERSION}-${TARGET}.tar.gz"

echo "Installing $BIN $VERSION for $TARGET..."
curl -fsSL "$URL" | tar xz
install -m755 "$BIN" "${DESTDIR:-/usr/local/bin}/$BIN"
rm -f "$BIN"
echo "Done. Run: $BIN --version"
