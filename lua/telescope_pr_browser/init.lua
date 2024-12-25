local conf = require('telescope.config').values
local pickers = require 'telescope.pickers'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local finders = require 'telescope.finders'
local previewers = require 'telescope.previewers'
local plenary = require 'plenary'
local log = require('plenary.log').new {
  plugin = 'telescope_pr_browser',
  level = 'info',
}
local prb_utils = require 'telescope_pr_browser.utils'
local entry_maker = require 'telescope_pr_browser.entry_maker'
local preview_definer = require 'telescope_pr_browser.preview_definer'

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
          return entry_maker.make(entry, log)
        end,
      },

      sorter = conf.generic_sorter(opts),

      previewer = previewers.new_buffer_previewer {
        title = 'PR Details',
        define_preview = function(self, entry)
          return preview_definer.define(self.state.bufnr, entry)
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
