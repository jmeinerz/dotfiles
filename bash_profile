#!bin/bash

[ -f ~/.bashrc ] && source ~/.bashrc

alias ls="ls -G"

# Git

alias gs="git status"
alias gd="git diff"
alias gb="git branch"
alias gl="git log"
alias gcm="git checkout master"
alias gprune="git remote prune origin"

# Bundler

alias be="bundle exec"
alias ber="bundle exec rake"
alias bes="bundle exec rspec"

PS1='\[\033[36m\]\w\[\033[m\]\[\033[33;32m\]$(current_git_branch)\[\033[0m\] \$ '

if [ -z "$TMUX" ]; then
  tat
fi
