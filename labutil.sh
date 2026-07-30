#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

usage_() {
  echo "Labutil - C++ project management tool"
  echo
  echo "Usage: labutil.sh <operation> [args] ..."
  echo
  echo "Operations:"
  echo "  init        Initialize a new C++ project"
  echo "  class       Create a new class with .h and .cpp files"
  echo "  update      Update labutil to the latest version"
  echo "  uninstall   Uninstall labutil"
  echo
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
