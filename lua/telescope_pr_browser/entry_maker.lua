local M = {}

-- Make entry in Telescope previewer.
function M.make(entry, log)
  local pr = vim.json.decode(entry)
  log.info('Got entry', pr)
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
