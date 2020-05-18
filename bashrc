[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export BASH_SILENCE_DEPRECATION_WARNING=1

# Git

source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh

# Graphic commits diff between two git branches
function gdc() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative "$1".."$2"
}

function current_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# ASDF

source /usr/local/opt/asdf/asdf.sh
source /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash

# RuboCop
function install_rubocop() {
  gem install rubocop rubocop-rails rubocop-rspec rubocop-performance rubocop-thread_safety
}

# Qonto

export QONTO_SRC_PATH=~/Qonto
export DATA_SRC_PATH=~/Qonto
source ~/Qonto/devenv/activate
eval "$(docker-machine env qonto)"
