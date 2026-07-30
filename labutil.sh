#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

usage_() {
  echo "Usage: labutil.sh <operation> [args]" >&2
  echo >&2
  echo "Operations:" >&2
  echo "  init        Initialize a new C++ project" >&2
  echo "  class       Create a new class with .h and .cpp files" >&2
  echo "  uninstall   Uninstall labutil" >&2
  exit 1
}

# MAIN -------------
if [[ $# -lt 1 ]]; then
  usage_
fi

OPERATION="$1"

if [[ $OPERATION == "--help" || $OPERATION == "-h" ]]; then
  usage_
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
    echo "Not yet implemented" >&2
    # source "$SCRIPT_DIR/uninstall.sh"
    # cmd_uninstall_ "${@:2}"
    ;;
  *)
    usage_
    ;;
esac
