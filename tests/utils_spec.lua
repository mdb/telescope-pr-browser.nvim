local utils = require 'telescope_pr_browser.utils'

-- TODO: could this be set globally during test runs?
vim.g.test = true

describe('utils', function()
  describe('open_url', function()
    it('returns true', function()
      local result = utils.open_url 'https://foo'
      assert.are.same(result, true)
      assert.are.same(vim.g.OPENINGH_RESULT, 'https://foo')
    end)
  end)
end)
