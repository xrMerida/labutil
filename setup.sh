#!/usr/bin/env bash

cmd_update_() {
  FORCE=false
  if [[ $# -gt 1 ]]; then
    echo "error: update: too many arguments" >&2
    exit 1;
  fi
  if [[ $# -eq 1 && $1 == "-f" ]]; then
    FORCE=true
  fi

  echo "Updating labutil..."
  cd "$SCRIPT_DIR" \
    || echo "setup: internal error: $SCRIPT_DIR does not exist"

  local FAILED=false
  if $FORCE; then
    git pull origin main -qf --rebase || FAILED=true
  else
    git pull origin main -q || FAILED=true
  fi

  # Check for failed updates
  if $FAILED; then
    echo "setup: update failed" >&2
    if ! $FORCE; then
      echo "use 'labutil update -f' force update" >&2
    fi
    exit 1
  fi
  echo "Done!"
}

cmd_uninstall_() {
  echo "Uninstalling labutil..."
  rm -rf "$SCRIPT_DIR"
  rm -f "${XDG_BIN_HOME:-$HOME/.local/bin}/labutil"
  echo "Done!"
}
