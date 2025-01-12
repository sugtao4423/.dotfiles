return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'dockerfile',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'yaml',
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
