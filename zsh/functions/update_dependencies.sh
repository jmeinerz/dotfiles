update_vim_plugins() {
  vim -u "$HOME"/.vimrc.bundles +PlugUpdate +PlugClean! +qa
}

update_dependencies() {
  brew upgrade
  update_vim_plugins
}
