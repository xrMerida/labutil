#!/usr/bin/env bash

cmd_class_() {
  # Class name
  local NAME="$1"

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

  # CMakeLists.txt file
  local CMAKETXT
  CMAKETXT="./CMakeLists.txt"

  if [[ ! -f "$CMAKETXT" ]]; then
    echo "class: error: not a valid project directory" >&2
    exit 1
  fi

  # Class lowercase name
  local LNAME
  LNAME="$(echo "$NAME" | tr '[:upper:]' '[:lower:]')"
  # Class uppercase name
  local UNAME
  UNAME="$(echo "$NAME" | tr '[:lower:]' '[:upper:]')"
  # Project's name
  local PROJ
  PROJ="$(grep -oPi '(?i)\bproject\(\K[^)]+' "$CMAKETXT")"
  # Project's lowercase name
  local LPROJ
  LPROJ="$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')"
  # .h file location
  local DOTH="./include/$LPROJ/$LNAME.h"
  # .cpp file location
  local DOTCPP="./src/$LNAME.cpp"

  # Create directories if they don't exist
  mkdir -p "$(dirname "$DOTCPP")"
  mkdir -p "$(dirname "$DOTH")"

  # Copy the dummy files
  cp "$SCRIPT_DIR/cmd_class/__LNAME.h" "$DOTH"
  cp "$SCRIPT_DIR/cmd_class/__LNAME.cpp" "$DOTCPP"

  # Replace placeholders with actual values
  sed --in-place "s/__NAME/$NAME/g" "$DOTCPP"
  sed --in-place "s/__LNAME/$LNAME/g" "$DOTCPP"
  sed --in-place "s/__UNAME/$UNAME/g" "$DOTCPP"

  sed --in-place "s/__NAME/$NAME/g" "$DOTH"
  sed --in-place "s/__LNAME/$LNAME/g" "$DOTH"
  sed --in-place "s/__UNAME/$UNAME/g" "$DOTH"

  echo "class: files '$DOTCPP' & '$DOTH' created successfully"
}
