#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

# Source command files
source "$SCRIPT_DIR/init.sh"
source "$SCRIPT_DIR/class.sh"

usage_() {
  echo "Usage: labutil.sh <operation> [args]"
  echo
  echo "Operations:"
  echo "  init    Initialize a new C++ project"
  echo "  class   Create a new class with .h and .cpp files"
}

# MAIN -------------
if [[ $# -lt 1 ]]; then
  usage_ >&2
  exit 1
fi

OPERATION="$1"

if [[ $OPERATION == "--help" || $OPERATION == "-h" ]]; then
:
fi

case "$OPERATION" in
  init)
    cmd_init_ "${@:2}"
    ;;
  class)
    cmd_class_ "${@:2}"
    ;;
  *)
    usage_ >&2
    exit 1
    ;;
esac
