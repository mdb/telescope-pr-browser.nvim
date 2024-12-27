local M = {}

-- Make entry in Telescope previewer.
function M.make(entry)
  local pr = vim.json.decode(entry)
  local mergeable = '  '
  if pr.mergeable == 'MERGEABLE' then
    mergeable = '✔ '
  end
  return {
    value = pr,
    display = mergeable .. pr.title,
    ordinal = pr.number .. ' ' .. pr.title,
  }
end

return M
