# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Disable ls colors
DISABLE_LS_COLORS="true"

# User local binaries
export PATH="$HOME/.local/bin:$PATH"

# Automatically switch Node versions when entering a directory with .nvmrc
export NVM_AUTO_USE=true

# Plugins
plugins=(
  git
  zsh-nvm
  zsh-autosuggestions
  fast-syntax-highlighting
  zsh-autocomplete
)

if [[ -f "${ZSH_CUSTOM:-$ZSH/custom}/plugins/yarn-autocompletions/yarn-autocompletions.plugin.zsh" ]]; then
  plugins+=(yarn-autocompletions)
fi

# Oh My Zsh runs compinit before it sources plugins, so zsh-autocomplete's helper
# functions must be on fpath first or they are missing from the completion dump.
fpath=("${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autocomplete/Completions" $fpath)

source "$ZSH/oh-my-zsh.sh"

# Keep Tab for completion (yarn scripts, etc). Accept autosuggestions with Ctrl-Y.
bindkey '^Y' autosuggest-accept

# Clear the entire line on Ctrl-U or Cmd+Delete (for terminals that send ^U or CSI-u)
bindkey '^U' kill-whole-line
bindkey '\e[127;9u' kill-whole-line
bindkey -M menuselect '^U' kill-whole-line
bindkey -M menuselect '\e[127;9u' kill-whole-line

# zsh-autocomplete + Oh My Zsh drops yarn-autocompletions' compdef (OMZ runs
# compinit first; autocomplete then discards deferred compdefs). Re-bind after init.
_fix_yarn_completion() {
  (( $+functions[_yarn] )) && _comps[yarn]=_yarn
  add-zsh-hook -d precmd _fix_yarn_completion
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _fix_yarn_completion
(( $+functions[_yarn] )) && _comps[yarn]=_yarn

# zsh-autocomplete history search limit
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 500
zstyle ':autocomplete:history-search-backward:*' list-lines 500

# Machine- or project-specific overrides (untracked)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
