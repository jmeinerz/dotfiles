# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# Local config
if [ "$SPIN" ]; then
  [[ -f ~/.zshrc.spin ]] && source ~/.zshrc.spin
else
  [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
fi

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
