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
  requires = {"rcarriga/nvim-notify", "nvim-lua/plenary.nvim"},
  cmd = "GithubCI",
  config = function()
    require('githubci').setup({
      -- sucess = "sucess",
      -- failure =  "failure",
      -- pending = "pending",
      view = "notify",
    })
  end
})
```
