vim.api.nvim_set_hl(0, 'LineNr', { fg = '#af5f00', ctermfg = 130 })

vim.api.nvim_set_hl(0, 'EoLSpace', { bg = 'darkred', ctermbg = 'darkred' })
vim.fn.matchadd('EoLSpace', [[\(\s\|　\)\+$]])
