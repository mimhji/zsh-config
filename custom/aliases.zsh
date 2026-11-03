# General
alias c="clear"
alias ls='ls -G'
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
dev() {
    cd ~/Documents/dev/"$1" || echo "Directory ~/Documents/dev/$1 not found"
}
alias vs="code ."

# Docker
alias dcu="docker compose up --build --no-log-prefix"
alias dcd="docker compose down"
alias dcr="docker compose restart"

# ZSH
alias zs="exec zsh -l"

# Node.js
alias rnm="rm -rf node_modules"

alias y="yarn"
alias ycc="yarn cache clean"
alias yi="yarn install"
alias ys="yarn serve"
alias yb="yarn build"
alias yd="yarn dev"
alias yt="yarn test"
alias ytc="yarn type-check"
alias yl="yarn lint"
alias yf="yarn format"

alias n="npm"
alias ncc="npm cache clean --force"
alias ni="npm install"
alias ns="npm serve"
alias nb="npm build"
alias nd="npm dev"
alias nt="npm test"
alias nl="npm lint"

# Git
alias g="git"
alias gst="git status"
alias gb="git branch"
alias gsw="git switch "
alias gpl="git pull"
alias gps="git push"
alias gm="git merge "
alias grst="git reset --soft HEAD^"
alias grb="git rebase "
alias ga="git add"
alias gc="git commit -m "
alias gstsh="g stash --include-untracked"
alias gpstsh="g stash pop"

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
