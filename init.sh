#!/usr/bin/env bash

cmd_init_() {
  if [[ $# -lt 1 ]]; then
    cat << EOF >&2
Usage: labutil.sh init <name> [destination]

  Create a new C++ project with <name> in [destination]
  if no [destination] is provided, use current directory
EOF
    exit 1
  fi
  if [[ $# -gt 2 ]]; then
    echo "init: error: too many arguments" >&2
    exit 1
  fi

  local TEMPLATE="$SCRIPT_DIR/cmd_init"
  local NAME="$1"
  local DEST="${2:-.}"
  local LNAME
  LNAME="$(echo "$NAME" | tr '[:upper:]' '[:lower:]')"

  # PROJECT CREATION -----------------------
  mkdir -p "$DEST"
  if [[ -d "$DEST" && -n $(ls -A "$DEST") ]]; then
    echo "init: error: destination '$DEST' is not empty" >&2
    exit 1
  fi

  if [[ ! -d $TEMPLATE ]]; then
    echo "init: internal error: cannot find template dir" >&2
    exit 1
  fi

  # Replace names -------------------
  while IFS= read -r file; do
    local dest="$DEST/${file#"$TEMPLATE"/}"
    mkdir -p "${dest%/*}"

    sed \
      -e "s/__NAME/$NAME/g" \
      -e "s/__LNAME/$LNAME/g" \
      "$file" \
      > "$dest"
  done < <(find "$TEMPLATE" -type f)


  mkdir -p "$DEST/include/$LNAME"

  echo "init: project initialized at '$DEST' with name '$NAME'"
}
