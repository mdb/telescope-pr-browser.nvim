[![CI/CD](https://github.com/mdb/telescope-pr-browser.nvim/actions/workflows/cicd.yaml/badge.svg)](https://github.com/mdb/telescope-pr-browser.nvim/actions/workflows/cicd.yaml)

# telescope-pr-browser.nvim

A Neovim plugin for browsing GitHub PRs using [telescope](https://github.com/nvim-telescope/telescope.nvim).

`telescope-pr-browser.nvim` provides a `:Telescope telescope_pr_browser list`
command for browsing the current git repository's open PRs using [telescope](https://github.com/nvim-telescope/telescope.nvim).

## Installation

`telescope-pr-browser.nvim` requires the [gh](https://cli.github.com/) CLI.

Installation example using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return {
  'mdb/telescope-pr-browser.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    {
      '<Leader>pl',
      ':Telescope telescope_pr_browser list<CR>',
      desc = '[P]R [L]list',
    },
  },
}
```
