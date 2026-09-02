#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/labutil"

usage_() {
  cat <<EOF
Labutil - C++ lab management tool

Usage: labutil.sh <operation> [args] ...

Operations:
  init        Initialize a new C++ project
  class       Create a new class with .h and .cpp files
  update      Update labutil to the latest version
  uninstall   Uninstall labutil
EOF
}

# MAIN -------------
if [[ $# -lt 1 ]]; then
  usage_ >&2
  exit 2
fi

OPERATION="$1"

if [[ $OPERATION == "--help" || $OPERATION == "-h" ]]; then
  usage_
  exit 0
fi

case "$OPERATION" in
  init)
    source "$SCRIPT_DIR/init.sh"
    cmd_init_ "${@:2}"
    ;;
  class)
    source "$SCRIPT_DIR/class.sh"
    cmd_class_ "${@:2}"
    ;;
  uninstall)
    source "$SCRIPT_DIR/setup.sh"
    cmd_uninstall_ "${@:2}"
    ;;
  update)
    source "$SCRIPT_DIR/setup.sh"
    cmd_update_ "${@:2}"
    ;;
  *)
    usage_ >&2
    exit 2
    ;;
esac
