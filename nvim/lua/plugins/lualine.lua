return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local theme = require 'lualine.themes.wombat'
    theme.normal.a.gui = nil
    theme.insert.a.gui = nil
    theme.visual.a.gui = nil
    theme.replace.a.gui = nil
    theme.inactive.a.gui = nil

    theme.normal.b = {
      bg = '#666666', -- base00
      fg = '#d0d0d0', -- base3
    }
    theme.normal.x = {
      bg = '#444444', -- base02
      fg = '#a8a8a8', -- base2
    }
    theme.normal.y = {
      bg = '#666666', -- base00
      fg = '#a8a8a8', -- base2
    }
    theme.inactive.b = theme.inactive.c

    local sections = {
      lualine_b = {
        {
          function()
            local readonly = vim.api.nvim_get_option_value('readonly', {})
            return readonly and 'RO' or ''
          end,
          color = {
            bg = '#ff0000', -- red
            fg = '#ffffff', -- white
          },
        },
        {
          'filename',
          symbols = {
            modified = ' +',
            readonly = '',
          },
        },
      },
      lualine_c = {},
    }

    local inactive_sections = {
      lualine_b = {
        {
          sections.lualine_b[1][1],
          color = theme.normal.x,
        },
        sections.lualine_b[2],
      },
      lualine_c = {},
    }

    require('lualine').setup({
      options = {
        icons_enabled = false,
        theme = theme,
        component_separators = { left = '', right = '|'},
        section_separators = '',
      },
      sections = sections,
      inactive_sections = inactive_sections,
    })
  end,
}
