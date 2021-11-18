# Github-CI.nvim

![2021-11-18-14:37:07](https://user-images.githubusercontent.com/4050749/142425528-e4614afa-aa5f-4859-a7a7-906efee0db23.png)

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
