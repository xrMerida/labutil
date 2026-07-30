INSTALL_DIR="${XDG_BIN_DIR:-$HOME/.local/bin}/.labutil"

cmd_update_() {
    echo "Updating labutil..."
    cd "$INSTALL_DIR" || exit 1
    git pull origin main
    echo "Done!"
}

cmd_uninstall_() {
    echo "Uninstalling labutil..."
    rm -rf "$INSTALL_DIR"
    rm "$INSTALL_DIR/../labutil"
    echo "Done!"
}
