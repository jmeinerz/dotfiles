require'lspconfig'.sorbet.setup{
  cmd = {'bundle', 'exec', 'srb', 'tc', '--lsp'}
}
