cmd_init_() {
  if [[ $# -lt 1 ]]; then
  echo "Usage: labutil.sh init <name> [destination]" >&2
  echo >&2
  echo "       Create a new C++ project with <name> in [destination]" >&2
  echo "       if no [destination] is provided, use ./<name>" >&2
  exit 1
  fi

  local TEMPLATE="$SCRIPT_DIR/cmd_init"
  if [[ ! -d $TEMPLATE ]]; then
    echo "Internal error: cannot find template dir" >&2
    exit 1
  fi

  local NAME="$1"
  local DEST="${2:-$NAME}"
  local LNAME
  LNAME="$(echo "$NAME" | tr '[:upper:]' '[:lower:]')"

  if [[ -d "$DEST" ]]; then
    echo "Error: destination '$DEST' already exists" >&2
    exit 1
  fi

  # Project creation --------
  cp -r "$TEMPLATE" "$DEST"

  find "$DEST" -type f -exec sed -i "s/__NAME/$NAME/g" {} +
  find "$DEST" -type f -exec sed -i "s/__LNAME/$LNAME/g" {} +

  mkdir -p "$DEST/include/$LNAME"

  echo "Created project at './$DEST' with name '$NAME'"
}
