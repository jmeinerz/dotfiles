update_vim_plugins() {
  nvim -u ~/.config/nvim/plugins.vim +PlugUpdate +PlugClean! +qa
}

update_dependencies() {
  brew upgrade
  update_vim_plugins
}
