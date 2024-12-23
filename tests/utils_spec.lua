local utils = require 'telescope_pr_browser.utils'

vim.g.test = true

describe('utils', function()
  describe('open_url', function()
    local url = 'https://foo'
    local result

    before_each(function()
      result = utils.open_url(url)
    end)

    it('returns true', function()
      assert.are.same(result, true)
    end)

    it('returns sets the passed URL in OPENINGH_RESULT', function()
      assert.are.same(vim.g.OPENINGH_RESULT, url)
    end)
  end)
end)
