#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_DIR="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$ZSH_DIR/custom}"

echo "==> Checking Oh My Zsh..."
if [[ ! -d "$ZSH_DIR" ]]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed at $ZSH_DIR"
fi

mkdir -p "$ZSH_CUSTOM_DIR/plugins"

clone_plugin() {
  local name="$1"
  local url="$2"
  local target="$ZSH_CUSTOM_DIR/plugins/$name"

  if [[ -d "$target/.git" ]]; then
    echo "==> Plugin $name already installed"
  elif [[ -d "$target" ]]; then
    echo "==> Plugin directory $target exists (skipping clone)"
  else
    echo "==> Cloning plugin $name..."
    git clone --depth=1 "$url" "$target"
  fi
}

clone_plugin "zsh-nvm" "https://github.com/lukechilds/zsh-nvm.git"
clone_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git"
clone_plugin "fast-syntax-highlighting" "https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
clone_plugin "zsh-autocomplete" "https://github.com/marlonrichert/zsh-autocomplete.git"

install_yarn_autocompletions() {
  local target="$ZSH_CUSTOM_DIR/plugins/yarn-autocompletions"
  if [[ -x "$target/yarn-autocompletions" && -f "$target/yarn-autocompletions.plugin.zsh" ]]; then
    echo "==> Plugin yarn-autocompletions already installed"
    return
  fi

  local cargo_bin=""
  if command -v cargo >/dev/null 2>&1; then
    cargo_bin="$(command -v cargo)"
  elif [[ -x "$HOME/.cargo/bin/cargo" ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
    cargo_bin="$HOME/.cargo/bin/cargo"
  fi

  if [[ -n "$cargo_bin" ]]; then
    echo "==> Building yarn-autocompletions from source with Cargo..."
    local tmp_dir
    tmp_dir="$(mktemp -d)"
    git clone --depth=1 https://github.com/g-plane/zsh-yarn-autocompletions.git "$tmp_dir/zsh-yarn-autocompletions"
    (
      cd "$tmp_dir/zsh-yarn-autocompletions"
      "$cargo_bin" build --release
      mkdir -p "$target"
      cp ./yarn-autocompletions.plugin.zsh "$target/"
      cp ./target/release/yarn-autocompletions "$target/"
    )
    rm -rf "$tmp_dir"
    echo "==> Installed yarn-autocompletions"
  else
    echo "==> Skipping yarn-autocompletions build (Rust/Cargo not found)."
    echo "    Install Rust via https://rustup.rs and re-run ./install.sh to build yarn-autocompletions."
  fi
}

install_yarn_autocompletions

link_file() {
  local src="$1"
  local dest="$2"

  if [[ -L "$dest" ]]; then
    local current_target
    current_target="$(readlink "$dest")"
    if [[ "$current_target" == "$src" ]]; then
      echo "==> Already linked: $dest -> $src"
      return
    fi
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    echo "==> Backing up existing $dest to $backup"
    mv "$dest" "$backup"
  fi

  ln -s "$src" "$dest"
  echo "==> Linked: $dest -> $src"
}

link_file "$REPO_DIR/.zshrc" "$HOME/.zshrc"
link_file "$REPO_DIR/.zprofile" "$HOME/.zprofile"
link_file "$REPO_DIR/custom/aliases.zsh" "$ZSH_CUSTOM_DIR/aliases.zsh"

echo "==> Done! Run 'exec zsh -l' to reload your shell."
