#!/usr/bin/env bash

cmd_update_() {
  echo "Updating labutil..."
  cd "$SCRIPT_DIR" || echo "setup: internal error: $SCRIPT_DIR does not exist"
  git pull origin main
  echo "Done!"
}

cmd_uninstall_() {
  echo "Uninstalling labutil..."
  rm -rf "$SCRIPT_DIR"
  rm "$SCRIPT_DIR/../labutil"
  echo "Done!"
}
