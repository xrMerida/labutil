#!/usr/bin/env sh

set -e

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

UPSTREAM_URL="https://github.com/xrMerida/labutil.git"
INSTALL_DIR="$XDG_DATA_HOME/labutil"
EXEC_FILE="$XDG_BIN_HOME/labutil"

# GPL Lisence disclaimer
cat <<EOF
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.

---
EOF

# Validate ---------
if [ -d "$INSTALL_DIR" ]; then
  echo "labutil is already installed in $INSTALL_DIR" >&2
  echo "update it using: labutil update" >&2
  exit 1
fi
if ! command -v git >/dev/null 2>&1; then
  echo "labutil requires git to be installed" >&2
  exit 1
fi

# Install process -----------
mkdir -p "$INSTALL_DIR"
git clone -q --depth=1 "$UPSTREAM_URL" "$INSTALL_DIR"

mkdir -p "$(dirname "$EXEC_FILE")"
cat <<EOF > "$EXEC_FILE"
#!/usr/bin/env sh

exec "\${XDG_DATA_HOME:-\$HOME/.local/share}/labutil/labutil.sh" "\$@"
EOF
chmod a+x "$EXEC_FILE"

# Check dependencies --------
if ! command -v cmake >/dev/null 2>&1; then
  echo "cmake neeeds to be installed" >&2
fi
if ! command -v clang >/dev/null 2>&1; then
  echo "clang neeeds to be installed" >&2
fi
if ! command -v ninja >/dev/null 2>&1; then
  echo "ninja neeeds to be installed" >&2
fi
if ! echo "$PATH" | grep -q "$XDG_BIN_HOME"; then
  echo "You must add $XDG_BIN_HOME to your PATH"
fi

echo "Installed at '$INSTALL_DIR'"
echo "run 'labutil' to get started"
