# zsh-config

Oh My Zsh configuration, custom aliases, and plugin bootstrap script for macOS.

## Prerequisites on a new Mac

1. **Command Line Tools for Xcode** (provides `git`):

```sh
xcode-select --install
```

2. **Homebrew** (optional, loaded in `.zprofile` if installed):

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. **Rust and Cargo** (optional, used by `install.sh` to compile `yarn-autocompletions` natively on Apple Silicon):

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
```

If Rust is not installed when you run `./install.sh`, the script skips `yarn-autocompletions` and `.zshrc` loads without it until you install Rust and re-run `./install.sh`.

## Setup on a new laptop

1. Clone this repository and run the installer:

```sh
mkdir -p ~/Documents/dev/personal
git clone https://github.com/mimhji/zsh-config.git ~/Documents/dev/personal/zsh-config
cd ~/Documents/dev/personal/zsh-config
./install.sh
```

2. Reload your shell:

```sh
exec zsh -l
```

### What `install.sh` does

1. Installs [Oh My Zsh](https://ohmyz.sh/) into `~/.oh-my-zsh` if it is not installed yet.
2. Clones the custom plugins into `~/.oh-my-zsh/custom/plugins/`:
   - [`lukechilds/zsh-nvm`](https://github.com/lukechilds/zsh-nvm)
   - [`zsh-users/zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions)
   - [`zdharma-continuum/fast-syntax-highlighting`](https://github.com/zdharma-continuum/fast-syntax-highlighting)
   - [`marlonrichert/zsh-autocomplete`](https://github.com/marlonrichert/zsh-autocomplete)
   - [`zsh-users/zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)
3. Clones and builds [`g-plane/zsh-yarn-autocompletions`](https://github.com/g-plane/zsh-yarn-autocompletions) with Cargo if `cargo` is available.
4. Backs up any existing `~/.zshrc`, `~/.zprofile`, and `~/.oh-my-zsh/custom/aliases.zsh` files with a `.bak.<timestamp>` suffix and symlinks them to this repository.

## Syncing changes between laptops

Because `~/.zshrc`, `~/.zprofile`, and `~/.oh-my-zsh/custom/aliases.zsh` are symlinked to this repo, any edits you make to those files happen directly inside the git working tree.

To push updates from one laptop:

```sh
cd ~/Documents/dev/personal/zsh-config
git add -A
git commit -m "Update aliases"
git push
```

To pull updates on another laptop:

```sh
cd ~/Documents/dev/personal/zsh-config
git pull
exec zsh -l
```

## Local machine overrides

To add machine-specific or project-specific settings without committing them to this repository, put them in either of these untracked files:

- `~/.zshrc.local` runs at the end of `.zshrc` (for project-specific aliases or tool paths).
- `~/.zprofile.local` runs at the end of `.zprofile` (for SDK paths or language runtime environment variables).

## Included keybindings and helpers

- `Ctrl-Y` accepts the current inline autosuggestion (`autosuggest-accept`), keeping `Tab` for standard menu completion.
- `dev <folder>` jumps to `~/Documents/dev/<folder>`.
- `zs` reloads the shell (`exec zsh -l`).
- `c` clears the terminal, `dl` jumps to `~/Downloads`, `dt` jumps to `~/Desktop`, and `vs` opens VS Code in the current directory (`code .`).
- `..`, `...`, `....`, `.....` navigate up 1 to 4 parent directories.

### Git aliases

| Alias | Command |
| :--- | :--- |
| `g` | `git` |
| `gst` | `git status` |
| `gb` | `git branch` |
| `gsw` | `git switch ` |
| `gpl` | `git pull` |
| `gps` | `git push` |
| `gm` | `git merge ` |
| `grst` | `git reset --soft HEAD^` |
| `grb` | `git rebase ` |
| `ga` | `git add` |
| `gc` | `git commit -m ` |
| `gstsh` | `git stash --include-untracked` |
| `gpstsh` | `git stash pop` |

### Node.js and Docker aliases

| Alias | Command |
| :--- | :--- |
| `rnm` | `rm -rf node_modules` |
| `y` / `yi` / `ycc` | `yarn` / `yarn install` / `yarn cache clean` |
| `yd` / `yb` / `ys` | `yarn dev` / `yarn build` / `yarn serve` |
| `yt` / `ytc` / `yl` / `yf` | `yarn test` / `yarn type-check` / `yarn lint` / `yarn format` |
| `n` / `ni` / `ncc` | `npm` / `npm install` / `npm cache clean --force` |
| `nd` / `nb` / `ns` / `nt` / `nl` | `npm dev` / `npm build` / `npm serve` / `npm test` / `npm lint` |
| `dcu` | `docker compose up --build --no-log-prefix` |
| `dcd` / `dcr` | `docker compose down` / `docker compose restart` |
