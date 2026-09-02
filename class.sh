#!/usr/bin/env bash

cmd_class_() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: labutil.sh class <name>" >&2
    echo >&2
    echo "  Create a new class with <name> in the current project" >&2
    exit 1
  fi
  if [[ $# -gt 1 ]]; then
    echo "class: error: too many arguments" >&2
    exit 1
  fi

  # Validate project direcotry -----------------
  local CMAKETXT
  CMAKETXT="./CMakeLists.txt"

  if [[ ! -f "$CMAKETXT" ]]; then
    echo "class: error: not a valid project directory" >&2
    exit 1
  fi

  # Class name
  local NAME="$1"
  # Class lowercase name
  local LNAME
  LNAME="$(echo "$NAME" | tr '[:upper:]' '[:lower:]')"
  # Project's name
  local PROJ
  PROJ="$(sed -nE 's/^[[:space:]]*project\(([^)]+)\).*/\1/Ip' "$CMAKETXT")"
  # Project's lowercase name
  local LPROJ
  LPROJ="$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')"
  # Class names
  local DOTH="./include/$LPROJ/$LNAME.h"
  local DOTCPP="./src/$LNAME.cpp"

  # Class creation ----------------
  mkdir -p "$(dirname "$DOTCPP")"
  mkdir -p "$(dirname "$DOTH")"

  # Redirect files with names replaced ---------------------
  local SRCDOTH="$SCRIPT_DIR/cmd_class/__LNAME.h"
  local SRCDOTCPP="$SCRIPT_DIR/cmd_class/__LNAME.cpp"

  sed \
    -e "s/__NAME/$NAME/g" \
    -e "s/__LNAME/$LNAME/g" \
    "$SRCDOTCPP" \
    > "$DOTCPP"

  sed \
    -e "s/__NAME/$NAME/g" \
    -e "s/__LNAME/$LNAME/g" \
    "$SRCDOTH" \
    > "$DOTH"


  echo "class: files '$DOTCPP' & '$DOTH' created successfully"
}
