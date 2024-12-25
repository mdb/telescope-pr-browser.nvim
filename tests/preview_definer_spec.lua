local stub = require 'luassert.stub'
local utils = require 'telescope.previewers.utils'

describe('preview_definer', function()
  local preview_definer = require 'telescope_pr_browser.preview_definer'

  describe('define', function()
    local buf = vim.api.nvim_create_buf(false, false)

    before_each(function()
      stub(vim.api, 'nvim_buf_set_lines')
      stub(utils, 'highlighter')
      preview_definer.define(buf, {
        value = {
          number = '1',
          title = 'Some title',
          author = {
            name = 'Foo Bar',
            login = 'fb',
          },
          body = 'hello',
          files = { {
            path = 'to/path',
          } },
        },
      })
    end)

    it('sets the content of the preview buffer', function()
      assert.stub(vim.api.nvim_buf_set_lines).was_called_with(buf, 0, 0, true, {
        '# 1: Some title',
        '',
        '[Foo Bar](https://github.com/fb)',
        '',
        'hello',
        '',
        '## Changed files',
        '',
        '* to/path',
      })
    end)

    it('highlights the content as markdown', function()
      assert.stub(utils.highlighter).was_called_with(buf, 'markdown')
    end)
  end)
end)
