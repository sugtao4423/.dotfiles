vim.api.nvim_set_hl(0, 'LineNr', { fg = '#af5f00', ctermfg = 130 })

vim.api.nvim_set_hl(0, 'EoLSpace', { bg = 'darkred', ctermbg = 'darkred' })
vim.fn.matchadd('EoLSpace', [[\(\s\|　\)\+$]])

vim.api.nvim_set_hl(0, 'CmpNormal', { bg = '#303030', ctermbg = 236, fg = '#ffffff', ctermfg = 15 })
vim.api.nvim_set_hl(0, 'CmpNormalSel', { bg = '#6c6c6c', ctermbg = 242 })
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { strikethrough = true, fg = '#808080', ctermfg = 8 })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#00ffd7', ctermfg = 50 })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpItemAbbrMatch' })
