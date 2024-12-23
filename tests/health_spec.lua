local health = require 'telescope_pr_browser.health'

describe('health', function()
  describe('check', function()
    describe('when the gh CLI is installed', function()
      local result

      before_each(function()
        result = health.check()
      end)

      it('returns true', function()
        assert.are.same(true, result)
      end)
    end)
  end)
end)
