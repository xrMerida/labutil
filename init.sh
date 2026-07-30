cmd_init_() {
  if [[ $# -lt 1 ]]; then
  echo "Usage: labutil.sh init <name> [destination]" >&2
  echo >&2
  echo "       Create a new C++ project with <name> in [destination]" >&2
  echo "       if no [destination] is provided, use current directory" >&2
  exit 1
  fi

  if [[ $# -gt 1 ]]; then
    echo "init: error: too many arguments" >&2
    exit 1
  fi

  local TEMPLATE="$SCRIPT_DIR/cmd_init"
  if [[ ! -d $TEMPLATE ]]; then
    echo "init: internal error: cannot find template dir" >&2
    exit 1
  fi

  local NAME="$1"
  local DEST="${2:-$PWD}"
  local LNAME
  LNAME="$(echo "$NAME" | tr '[:upper:]' '[:lower:]')"

  mkdir -p "$DEST" >/dev/null 2>&1
  # Check if folder is empty
  if [[ -n $(ls -A "$DEST") ]]; then
    echo "init: error: destination '$DEST' is not empty" >&2
    exit 1
  fi

  # Project creation --------
  cp -a "$TEMPLATE/." "$DEST"

  find "$DEST" -type f -exec sed -i "s/__NAME/$NAME/g" {} +
  find "$DEST" -type f -exec sed -i "s/__LNAME/$LNAME/g" {} +

  mkdir -p "$DEST/include/$LNAME"

  echo "init: project initialized at '$DEST' with name '$NAME'"
}
