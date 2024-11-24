-- Rerun tests only if their modification time changed.
std = luajit

codes = true

self = false

-- Reference: https://luacheck.readthedocs.io/en/stable/warnings.html
ignore = {
  -- Neovim lua API + luacheck incorectly believes variables like `vim.wo.spell = true`
  -- to be invalid, hence rule `W122`.
  '122',
}

-- Global objects defined by the C code
read_globals = { 'vim' }

exclude_files = {
  'lua/plenary.nvim',
  'lua/telescope.nvim',
}
