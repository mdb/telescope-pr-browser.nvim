local telescope_pr_browser = require 'telescope_pr_browser'

return require('telescope').register_extension {
  exports = {
    list = telescope_pr_browser.list_prs,
  },
}
