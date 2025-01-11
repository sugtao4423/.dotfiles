return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  config = function()
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    local cmp = require('cmp')

    local completion = function(fallback, fun)
      if not cmp[fun]() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end

    local next = function(fallback) completion(fallback, 'select_next_item') end
    local prev = function(fallback) completion(fallback, 'select_prev_item') end

    cmp.setup({
      mapping = {
        ['<Tab>'] = next,
        ['<S-Tab>'] = prev,
        ['<Down>'] = next,
        ['<Up>'] = prev,
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      },
      sources = {
        { name = 'buffer' },
        { name = 'path' },
      },
    })
  end,
}
