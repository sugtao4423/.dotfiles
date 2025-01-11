local colors = {
  { 'LineNr', { fg = '#af5f00', ctermfg = 130 } },
  { 'EoLSpace', { bg = 'darkred', ctermbg = 'darkred' } },

  { 'CmpNormal', { bg = '#303030', ctermbg = 236, fg = '#ffffff', ctermfg = 15 } },
  { 'CmpNormalSel', { bg = '#6c6c6c', ctermbg = 242 } },
  { 'CmpItemAbbrDeprecated', { strikethrough = true, fg = '#808080', ctermfg = 8 } },
  { 'CmpItemAbbrMatch', { fg = '#00ffd7', ctermfg = 50 } },
  { 'CmpItemAbbrMatchFuzzy', { link = 'CmpItemAbbrMatch' } },
}

for _, v in ipairs(colors) do
  local name = v[1]
  local val = v[2]
  vim.api.nvim_set_hl(0, name, val)
end

vim.fn.matchadd('EoLSpace', [[\(\s\|　\)\+$]])
