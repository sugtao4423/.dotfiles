local function on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', '<C-e>', api.tree.toggle, opts('NvimTreeToggle'))
end

return {
  'nvim-tree/nvim-tree.lua',
  opts = {
    on_attach = on_attach,
    renderer = {
      icons = {
        show = {
          file = false,
          folder = false,
          folder_arrow = true,
          git = true,
          modified = false,
          hidden = false,
          diagnostics = false,
          bookmarks = false,
        },
        glyphs = {
          folder = {
            arrow_closed = '▸',
            arrow_open = '▾',
          },
        },
      },
    },
  },
  config = function(_, opts)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('nvim-tree').setup(opts)
  end,
}
