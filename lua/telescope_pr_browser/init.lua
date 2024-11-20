local conf = require('telescope.config').values
local pickers = require 'telescope.pickers'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local finders = require 'telescope.finders'
local previewers = require 'telescope.previewers'
local utils = require 'telescope.previewers.utils'
local plenary = require 'plenary'
local log = require('plenary.log').new {
  plugin = 'telescope_pr_browser',
  level = 'info',
}
local prb_utils = require 'telescope_pr_browser.utils'

---@class TPRBModule
---@field config TPRBConfig
---@field setup fun(TPRBConfig): TPRBModule

---@class TPRBConfig
local M = {}

---@param args string[]
---@return string[]
M._make_gh_command = function(args)
  local job_opts = {
    command = 'gh',
    args = vim.tbl_flatten { args, '--json', 'number,title,url,body,author,mergeable,files', '--jq', '.[]' },
  }
  log.info('Running job', job_opts)
  local job = plenary.job:new(job_opts):sync()
  log.info('Ran job', vim.inspect(job))
  return job
end

M.list_prs = function(opts)
  pickers
    .new(opts, {
      finder = finders.new_dynamic {
        fn = function()
          return M._make_gh_command { 'pr', 'list' }
        end,

        entry_maker = function(entry)
          log.info('Got entry', entry)
          local process = vim.json.decode(entry)
          log.info('Got entry', process)
          if process then
            local mergeable = '  '
            if process.mergeable == 'MERGEABLE' then
              mergeable = '✔ '
            end
            return {
              value = process,
              display = mergeable .. process.title,
              ordinal = process.number .. ' ' .. process.title,
            }
          end
        end,
      },

      sorter = conf.generic_sorter(opts),

      previewer = previewers.new_buffer_previewer {
        title = 'PR Details',
        define_preview = function(self, entry)
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
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true, formatted)
          utils.highlighter(self.state.bufnr, 'markdown')
        end,
      },

      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          log.info('Got selection', selection.value.title)
          actions.close(prompt_bufnr)
          prb_utils.open_url(selection.value.url)
        end)
        return true
      end,
    })
    :find()
end

---@param config TPRBConfig
M.setup = function(config)
  M.config = config
end

return M
