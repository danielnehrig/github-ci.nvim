local M = {}

function M.setup(opt)
end

function M.ci()
  vim.cmd([[packadd nvim-notify]])
  local notify = require("notify")
  notify.setup({
    -- Animation style (see below for details)
    -- stages = "fade",
    -- Default timeout for notifications
    timeout = 3000,
    -- For stages that change opacity this is treated as the highlight behind the window
    background_colour = "NotifyBG",
    -- Icons for the different levels
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
    },
  })
  local Job = require("plenary.job")
  local ci = { "LOADING" }
  Job
    :new({
      command = "hub",
      args = { "ci-status", "-f", "%t%n%S%n" },
      on_exit = function(j, _)
        local result = ""
        local count = 0
        ci = j:result()
        local failed = false

        for _, msg in ipairs(ci) do
          local str = msg
          if msg == "success" then
            str = "✔️"
          end
          if msg == "failure" then
            failed = true
            str = "❌"
          end
          if msg == "pending" then
            str = "🟠"
          end
          if count >= 1 then
            result = result .. str .. "\n"
            count = 0
          else
            result = result .. str
            count = count + 1
          end
        end

        if failed then
          notify(result, "error", { title = "Github CI" })
        else
          notify(result, "success", { title = "Github CI" })
        end
      end,
    })
    :start()
end

return M
