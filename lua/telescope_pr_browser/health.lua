local health = vim.health or require 'health'

local M = {}

M.check = function()
  health.start 'Checking...'
  if vim.fn.executable 'gh' == 1 then
    health.ok 'gh CLI installed.'
  else
    health.error 'gh CLI not fund.'
  end
end

return M
