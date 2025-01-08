local char = '▏'

local highlight_colors = {
  'IndentRainbowRed',     { fg = '#e06c75', ctermfg = 168 },
  'IndentRainbowYellow',  { fg = '#e5c07b', ctermfg = 180 },
  'IndentRainbowBlue',    { fg = '#61afef', ctermfg = 75 },
  'IndentRainbowOrange',  { fg = '#d19a66', ctermfg = 173 },
  'IndentRainbowGreen',   { fg = '#98c379', ctermfg = 114 },
  'IndentRainbowViolet',  { fg = '#c678dd', ctermfg = 176 },
  'IndentRainbowCyan',    { fg = '#56b6c2', ctermfg = 73 },
}
local highlight = {}

for i = 1, #highlight_colors, 2 do
  local name = highlight_colors[i]
  local color = highlight_colors[i + 1]
  table.insert(highlight, name)
  vim.api.nvim_set_hl(0, name, color)
end

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  ---@module 'ibl'
  ---@type ibl.config
  opts = {
    indent = {
      char = char,
      highlight = highlight,
      smart_indent_cap = false,
    },
  },
  config = function(_, opts)
    local hooks = require 'ibl.hooks'
    hooks.register(hooks.type.VIRTUAL_TEXT, function(_, _, _, virt_text)
      if virt_text[1] and virt_text[1][1] == char then
        virt_text[1] = { ' ', { '@ibl.whitespace.char.1' } }
      end
      return virt_text
    end)

    require('ibl').setup(opts)
  end,
}
