describe('entry_maker', function()
  local entry_maker = require 'telescope_pr_browser.entry_maker'
  local log = require('plenary.log').new {
    plugin = 'telescope_pr_browser',
    level = 'info',
  }

  describe('make', function()
    describe('the table it returns', function()
      local result

      before_each(function()
        result = entry_maker.make(
          vim.json.encode {
            number = '1',
            title = 'Some title',
          },
          log
        )
      end)

      it('has a display', function()
        assert.are.same('  Some title', result.display)
      end)

      it('has an ordinal display', function()
        assert.are.same('1 Some title', result.ordinal)
      end)

      it('has a value', function()
        assert.are.same('1', result.value.number)
        assert.are.same('Some title', result.value.title)
      end)
    end)

    describe('when the PR is mergeable', function()
      local result

      before_each(function()
        result = entry_maker.make(
          vim.json.encode {
            number = '1',
            title = 'Some title',
            mergeable = 'MERGEABLE',
          },
          log
        )
      end)

      it('denotes mergeability in the display', function()
        assert.are.same('✔ Some title', result.display)
      end)
    end)
  end)
end)
