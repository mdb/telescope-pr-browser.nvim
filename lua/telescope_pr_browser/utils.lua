local M = {}

-- Open a URL in in a web browser.
function M.open_url(url)
  -- when running in test env store the url
  if vim.g.test then
    vim.g.OPENINGH_RESULT = url
    return true
  end

  if vim.fn.has 'mac' == 1 then
    vim.fn.system('open ' .. url)
    return true
  end

  if vim.fn.has 'wsl' == 1 then
    vim.fn.system('explorer.exe ' .. url)
    return true
  end

  if vim.fn.has 'win64' == 1 or vim.fn.has 'win32' == 1 then
    vim.fn.system('start ' .. url)
    return true
  end

  if vim.fn.has 'linux' == 1 then
    vim.fn.system('xdg-open ' .. url)
    return true
  end

  return false
end

return M
