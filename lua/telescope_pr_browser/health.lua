local health = vim.health or require 'health'

local M = {}

M.check = function()
  health.start 'Checking...'
  if vim.fn.executable 'gh' == 1 then
    health.ok 'gh CLI installed.'
    return true
  else
    health.error 'gh CLI not found.'
    return false
  end
end

return M
