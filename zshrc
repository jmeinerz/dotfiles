# set up fzf
eval "$(fzf --zsh)"

bindkey "^[f" forward-word
bindkey "^[b" backward-word

[ -f /usr/local/opt/asdf/libexec/asdf.sh ] && . /usr/local/opt/asdf/libexec/asdf.sh
[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ] && . /opt/homebrew/opt/asdf/libexec/asdf.sh

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

export PATH="$HOME/.bin:$PATH"

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' %b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST

PROMPT='%F{blue}%~%F{green}${vcs_info_msg_0_}%f %# '

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

if [ -z "$TMUX" ]; then
  tat
fi
