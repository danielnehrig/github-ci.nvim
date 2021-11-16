# Github-CI.nvim

## THIS IS WIP NOT WORKING YET FULLY

## Requirements

- Hub (cli tool hub)
  - mac: brew install hub
  - yay: yay -S hub
- Plenary
- nvim-notify

## Install Packer

```lua
use({
  "danielnehrig/github-ci.nvim",
  requires = { "nvim-lua/plenary.nvim", "rcarriga/nvim-notify" },
  cmd = { "GithubCI" },
  config = function()
    vim.cmd([[packadd nvim-notify]]) -- notify is a optional dependency
    require("githubci").setup()
  end,
})
```
