[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.bin:$PATH"

if [ -z "$TMUX" ]; then
  tat
fi
