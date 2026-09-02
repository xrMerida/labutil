#!/usr/bin/env sh

set -e

if [ -d "$INSTALL_DIR" ]; then
  echo "labutil is already installed in $INSTALL_DIR" >&2
  echo "update it using: labutil update" >&2
  exit 1
fi

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

UPSTREAM_URL="https://github.com/xrMerida/labutil.git"
INSTALL_DIR="$XDG_DATA_HOME/labutil"
EXEC_FILE="$XDG_BIN_HOME/labutil"

# GPL Lisence disclaimer
echo "labutil is free software: you can redistribute it and/or modify"
echo "it under the terms of the GNU General Public License as published by"
echo "the Free Software Foundation, either version 3 of the License, or"
echo "(at your option) any later version."
echo
echo "labutil is distributed in the hope that it will be useful,"
echo "but WITHOUT ANY WARRANTY; without even the implied warranty of"
echo "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
echo "GNU General Public License for more details."
echo

# Validate ---------
if ! command -v git >/dev/null 2>&1; then
  echo "labutil requires git to be installed" >&2
  exit 1
fi

# Install process -----------
echo "Installing labutil into $INSTALL_DIR ..."
mkdir -p "$INSTALL_DIR"
git clone -q --depth=1 "$UPSTREAM_URL" "$INSTALL_DIR"

cat <<EOF > "$EXEC_FILE"
#!/usr/bin/env sh

exec "\${XDG_DATA_HOME:-\$HOME/.local/share}/labutil/labutil.sh" "\$@"
EOF
chmod a+x "$EXEC_FILE"

echo
echo "====== Installed ======"

if ! echo "$PATH" | grep -q "$XDG_BIN_HOME"; then
  echo "You must add $XDG_BIN_HOME to your PATH"
  echo "then run 'labutil' to get started"
else
  echo "Installed at '$INSTALL_DIR'"
  echo "run 'labutil' to get started"
fi
