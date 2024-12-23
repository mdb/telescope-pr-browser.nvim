local health = require 'telescope_pr_browser.health'

describe('utils', function()
  describe('check', function()
    it('returns true when the gh CLI is installed', function()
      local result = health.check()
      assert.are.same(true, result)
    end)
  end)
end)
