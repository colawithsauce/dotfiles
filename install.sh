#!/bin/bash
#
# This script creates symlinks from the dotfiles in this repository to their
# corresponding locations in the home directory. It also backs up any existing
# dotfiles that would be overwritten.

set -e # Exit immediately if a command exits with a non-zero status.

# The directory of this script, which is the root of the dotfiles repository.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
# Backup directory for any existing dotfiles that will be replaced.
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d%H%M%S)"

# --- Helper Functions ---

# A function to print info messages.
info() {
  # shellcheck disable=SC2059
  printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

# A function to create a symlink, backing up the original file if it exists.
# Usage: link_file "source_path" "destination_path"
link_file() {
  local src=$1
  local dst=$2

  # Create destination directory if it doesn't exist.
  mkdir -p "$(dirname "$dst")"

  # If the destination exists and is not a symlink to the source, back it up.
  if [ -e "$dst" ] && [ "$(readlink -f "$dst")" != "$src" ]; then
    info "Backing up existing file: $dst"
    # Ensure the backup directory structure exists.
    mkdir -p "$(dirname "$BACKUP_DIR/$dst")"
    mv "$dst" "$BACKUP_DIR/$dst"
  fi

  # If a correct symlink already exists, do nothing.
  if [ -L "$dst" ] && [ "$(readlink -f "$dst")" == "$src" ]; then
    info "Link already exists: $dst -> $src"
    return
  }

  # Remove broken symlinks at the destination.
  if [ -L "$dst" ]; then
    rm "$dst"
  fi

  info "Linking $src -> $dst"
  ln -s "$src" "$dst"
}

# --- Main Execution ---

echo "🚀 Starting dotfiles setup..."
echo "Dotfiles directory: $DOTFILES_DIR"
echo "Backup directory:   $BACKUP_DIR"
echo ""

# 1. Link contents of 'dotconfig' to '~/.config'
# This handles all configuration files that follow the XDG Base Directory Spec.
info "--- Linking .config files ---"
CONFIG_SRC_DIR="$DOTFILES_DIR/dotconfig"
CONFIG_DST_DIR="$HOME/.config"
if [ -d "$CONFIG_SRC_DIR" ]; then
  # Use find to iterate over all items in the source directory.
  # -mindepth 1 ensures we don't process the top-level directory itself.
  find "$CONFIG_SRC_DIR" -mindepth 1 -maxdepth 1 | while read -r src_item; do
    item_name=$(basename "$src_item")
    link_file "$src_item" "$CONFIG_DST_DIR/$item_name"
  done
fi
echo ""

# 2. Link contents of specified home directories (e.g., bash/, .vim/) to ~
# These are directories containing files/folders that should be in the root
# of the home directory (e.g., .bashrc, .vimrc, .vim/).
info "--- Linking home directory files ---"
# List of directories whose *contents* should be linked into $HOME.
DIRECTORIES_TO_LINK_CONTENT=("bash" "git" "profile" "vim" "zsh" "editorconfig")

for dir in "${DIRECTORIES_TO_LINK_CONTENT[@]}"; do
  source_dir="$DOTFILES_DIR/$dir"
  if [ -d "$source_dir" ]; then
    # Using `ls -A` to include hidden files (dotfiles) in the loop.
    for item in $(ls -A "$source_dir"); do
      link_file "$source_dir/$item" "$HOME/$item"
    done
  fi
done
echo ""

echo "✅ Dotfiles setup complete!"
echo "A backup of any overwritten files is located in: $BACKUP_DIR"
