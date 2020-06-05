# Graphic commits diff between two git branches
function gdc() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative "$1".."$2"
}

function current_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'
}
