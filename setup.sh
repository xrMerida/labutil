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

  if $FORCE; then
    git pull origin main -f --rebase
  else
    git pull origin main
  fi

  if [[ $? -ne 0 && ! $FORCE ]]; then
    echo "Use '-f' flag to force update"
    exit 1
  fi
  echo "Done!"
}

cmd_uninstall_() {
  echo "Uninstalling labutil..."
  rm -rf "$SCRIPT_DIR"
  rm "$SCRIPT_DIR/../labutil"
  echo "Done!"
}
