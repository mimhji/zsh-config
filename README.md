# zsh-config

Oh My Zsh configuration, custom aliases, and plugin bootstrap script for macOS.

## Included components

- `.zshrc` configures Oh My Zsh with the `robbyrussell` theme, custom plugins, `Ctrl-Y` to accept autosuggestions, and a `precmd` hook so `yarn-autocompletions` works alongside `zsh-autocomplete`.
- `.zprofile` sets up Homebrew, NVM (`NVM_AUTO_USE=true`), and `~/.local/bin`.
- `custom/aliases.zsh` defines aliases for Git, Docker Compose, Yarn, npm, and directory navigation.
- `install.sh` installs Oh My Zsh, clones custom plugins, builds `yarn-autocompletions` from source with Cargo, and symlinks the config files into `$HOME` and `$ZSH_CUSTOM`.

## Plugins installed by `install.sh`

- `git` (built into Oh My Zsh)
- [`lukechilds/zsh-nvm`](https://github.com/lukechilds/zsh-nvm)
- [`zsh-users/zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions)
- [`zdharma-continuum/fast-syntax-highlighting`](https://github.com/zdharma-continuum/fast-syntax-highlighting)
- [`marlonrichert/zsh-autocomplete`](https://github.com/marlonrichert/zsh-autocomplete)
- [`zsh-users/zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)
- [`g-plane/zsh-yarn-autocompletions`](https://github.com/g-plane/zsh-yarn-autocompletions) (built with Cargo if Rust is installed)

## Setup on a new machine

1. Clone this repository and run the installer:

```sh
git clone https://github.com/mimhji/zsh-config.git ~/Documents/dev/personal/zsh-config
cd ~/Documents/dev/personal/zsh-config
./install.sh
```

2. Reload the shell:

```sh
exec zsh -l
```

Existing `.zshrc`, `.zprofile`, and `$ZSH_CUSTOM/aliases.zsh` files are backed up with a `.bak.<timestamp>` suffix before symlinks are created.

## Local machine overrides

To add machine-specific or project-specific settings without committing them to this repository, create either of these untracked files:

- `~/.zshrc.local` is sourced at the end of `.zshrc`.
- `~/.zprofile.local` is sourced at the end of `.zprofile`.
