# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/etc/bash_completion.d/nvm" ] && \. "$NVM_DIR/etc/bash_completion.d/nvm"

export NVM_AUTO_USE=true

# User local binaries
export PATH="$HOME/.local/bin:$PATH"

# Machine-specific profile overrides (untracked)
[[ -f "$HOME/.zprofile.local" ]] && source "$HOME/.zprofile.local"
