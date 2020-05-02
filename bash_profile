#!bin/bash

alias ls="ls -G"

[ -f ~/.bashrc ] && source ~/.bashrc

# Git

source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh

alias gs="git status"
alias gd="git diff"
alias gb="git branch"
alias gl="git log"
alias gcm="git checkout master"
alias gprune="git remote prune origin"

# Graphic commits diff between two git branches
function gdc() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative "$1".."$2"
}

function current_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Bundler

alias be="bundle exec"
alias ber="bundle exec rake"
alias bes="bundle exec rspec"

# RuboCop
function install_rubocop() {
  gem install rubocop rubocop-rails rubocop-rspec rubocop-performance rubocop-thread_safety
}

# ASDF

source /usr/local/opt/asdf/asdf.sh
source /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash

# Qonto

export QONTO_SRC_PATH=~/Qonto
export DATA_SRC_PATH=~/Qonto
source ~/Qonto/devenv/activate
eval "$(docker-machine env qonto)"

PS1='\[\033[36m\]\u\[\033[m\]:\[\033[33;32m\]\w\[\033[m\]\[\033[0;31m\]$(current_git_branch)\[\033[0m\] \$ '
