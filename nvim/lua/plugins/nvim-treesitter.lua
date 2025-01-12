return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  enabled = function()
    local compilers = { 'cc', 'gcc', 'clang', 'cl', 'zig' }
    for _, compiler in ipairs(compilers) do
      if vim.fn.executable(compiler) == 1 then
        return true
      end
    end
    vim.notify('No C compiler found! nvim-treesitter is disabled.', vim.log.levels.WARN)
    return false
  end,
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
