[![CI/CD](https://github.com/mdb/telescope-pr-browser.nvim/actions/workflows/cicd.yaml/badge.svg)](https://github.com/mdb/telescope-pr-browser.nvim/actions/workflows/cicd.yaml)

> [!CAUTION]
> Early in development

# telescope-pr-browser.nvim

A Neovim plugin for browsing GitHub PRs using [telescope](https://github.com/nvim-telescope/telescope.nvim).

* `telescope-pr-browser.nvim` provides a `:Telescope telescope_pr_browser list`
command for browsing the current git repository's open PRs using [telescope](https://github.com/nvim-telescope/telescope.nvim).
* `Enter` on the selected PR to open the PR in your default web browser.

## Installation

`telescope-pr-browser.nvim` requires the [gh](https://cli.github.com/) CLI.

Example installation configuration using [lazy.nvim](https://github.com/folke/lazy.nvim):

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

## Development

Development dependencies:

* luarocks
* luacheck
