#!/usr/bin/env sh
# Install script for labutil

set -e

XDG_BIN_DIR="${XDG_BIN_DIR:-$HOME/.local/bin}"
UPSTREAM_URL="https://github.com/xrMerida/labutil.git"

echo "Installing labutil into $XDG_BIN_DIR"
mkdir -p "$XDG_BIN_DIR"
git clone "$UPSTREAM_URL" "$XDG_BIN_DIR/labutil"
ln -s "$XDG_BIN_DIR/labutil/labutil.sh" "$XDG_BIN_DIR/labutil"
echo "Done!"
