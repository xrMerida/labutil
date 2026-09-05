#!/usr/bin/env bash

cmd_update_() {
  if [[ $# -gt 1 ]]; then
    echo "error: update: too many arguments" >&2
    exit 1;
  fi
  if [[ $# -eq 1 && $1 == "-f" ]]; then
    FORCE=true
  fi

  echo "Updating labutil..."

  if [[ -z "$FORCE" ]]; then
    git -C "$SCRIPT_DIR" pull origin main -qf --rebase || FAILED=true
  else
    git -C "$SCRIPT_DIR" pull origin main -q || FAILED=true
  fi

  # Check for failed updates
  if [[ -z "$FAILED" ]]; then
    echo "setup: update failed" >&2
    if [[ ! $FORCE ]]; then
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
