local map = {
  { 'i', 'jj', '<ESC>', { silent = true } },
  { 'n', 'j', 'gj' },
  { 'n', 'k', 'gk' },
  { 'n', '<Down>', 'gj' },
  { 'n', '<Up>', 'gk' },
}

for _, v in ipairs(map) do
  local mode = v[1]
  local lhs = v[2]
  local rhs = v[3]
  local opts = v[4] or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end
