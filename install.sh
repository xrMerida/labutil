#!/usr/bin/env sh

set -e

XDG_BIN_DIR="${XDG_BIN_DIR:-$HOME/.local/bin}"
INSTALL_DIR="$XDG_BIN_DIR/.labutil"
UPSTREAM_URL="https://github.com/xrMerida/labutil.git"

# Validate
if ! command -v git >/dev/null 2>&1; then
  echo "labutil requires git to be installed" >&2
  exit 1
fi
if [ -d "$INSTALL_DIR" ]; then
  echo "labutil is already installed in $INSTALL_DIR" >&2
  echo "update it using: labutil update" >&2
  exit 1
fi

# Install script for labutil
echo "Installing labutil into $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
git clone "$UPSTREAM_URL" "$INSTALL_DIR"
echo "Creating symlink for labutil in $XDG_BIN_DIR"
rm -fr "$XDG_BIN_DIR/labutil"
ln -s "$INSTALL_DIR/labutil.sh" "$XDG_BIN_DIR/labutil"
echo "Done! Run 'labutil' to get started"
