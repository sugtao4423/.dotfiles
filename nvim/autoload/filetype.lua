local two_indent_ft = {
  'markdown',
  'sh',
  'lua',
  'json',
  'yaml',
  'html',
  'javascript',
  'typescript',
  'css',
  'scss',
}

local augroup = vim.api.nvim_create_augroup('filetype_indent', {})
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = two_indent_ft,
  callback = function ()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
  end
})
