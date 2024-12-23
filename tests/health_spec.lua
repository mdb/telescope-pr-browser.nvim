local mock = require 'luassert.mock'

describe('health', function()
  local health = require 'telescope_pr_browser.health'

  describe('check', function()
    local fn
    local vim_health

    before_each(function()
      fn = mock(vim.fn, true)
      vim_health = mock(vim.health, true)
    end)

    after_each(function()
      mock.revert(fn)
      mock.revert(vim_health)
    end)

    describe('when the gh CLI is installed', function()
      local result

      before_each(function()
        fn.executable.returns(1)
        result = health.check()
      end)

      it('returns true', function()
        assert.are.same(true, result)
      end)
    end)

    describe('when the gh CLI is not installed', function()
      local result

      before_each(function()
        fn.executable.returns(0)
        result = health.check()
      end)

      it('returns false', function()
        assert.are.same(false, result)
      end)
    end)
  end)
end)
