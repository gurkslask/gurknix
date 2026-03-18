-- go
require('go').setup()
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {'*.go'},
  callback = function()
      vim.lsp.buf.formatting_sync()
      OrgImports(1000)
  end,
  group = vim.api.nvim_create_augroup("lsp_document_format", {clear = true}),
})
