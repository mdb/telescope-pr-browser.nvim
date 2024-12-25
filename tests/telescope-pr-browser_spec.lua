describe('telescope-pr-browser', function()
  local tprb = require 'telescope_pr_browser'

  describe('setup', function()
    it('sets the config to the specified table', function()
      local config = { foo = 'bar' }
      tprb.setup(config)
      assert.are.same(tprb.config, config)
    end)
  end)
end)
