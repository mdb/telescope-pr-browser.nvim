local utils = require 'telescope.previewers.utils'

local M = {}

-- Define Telescope previewer.
function M.define(bufnr, entry)
  local name = entry.value.author.login
  if entry.value.author.name ~= '' then
    name = entry.value.author.name
  end
  local formatted = {
    '# ' .. entry.value.number .. ': ' .. entry.value.title,
    '',
    '[' .. name .. '](https://github.com/' .. entry.value.author.login .. ')',
    '',
  }
  for _, line in ipairs(vim.split(entry.value.body, '\r\n')) do
    local sanitized = line:gsub('[\n\r]', '')
    table.insert(formatted, sanitized)
  end
  table.insert(formatted, '')
  table.insert(formatted, '## Changed files')
  table.insert(formatted, '')
  for _, file in ipairs(entry.value.files) do
    table.insert(formatted, '* ' .. file.path)
  end
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, formatted)
  utils.highlighter(bufnr, 'markdown')
end

return M
