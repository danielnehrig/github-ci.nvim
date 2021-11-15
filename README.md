# Github-CI.nvim

## Requirements

- Hub (cli tool hub)
- Plenary
- notify.nvim

## Install

```lua
use({
  "danielnehrig/github-ci.nvim",
  requires = {"notify.nvim", "plenary"},
  cmd = "GithubCI",
  config = function()
    require('githubci').setup({
      sucess = "sucess",
      failure =  "failure",
      pending = "pending"
    })
  end
})
```
