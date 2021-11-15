local M = {}

vim.api.nvim_exec(
  [[
  command! GithubCI lua require('githubci').ci()
  ]],
  false
)

M.defaults = {
  sucess = "✔️",
  failure = "❌",
  pending = "🟠",
  view = "notify",
}

M.config = {}

function M.setup(opt)
  M.config = vim.tbl_deep_extend("force", {}, M.defaults, opt)
end

function M.notify(msg, type)
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

  notify(msg, type, { title = "Github CI" })
end

function M.float(result)
  -- TODO
end

function M.ci()
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

        for _, msg in ipairs(ci) do
          local str = msg
          if msg == "success" then
            str = M.config.success
          end
          if msg == "failure" then
            str = M.config.failure
          end
          if msg == "pending" then
            str = M.config.pending
          end

          if count >= 1 then
            result = result .. str .. "\n"
            count = 0
          else
            result = result .. str
            count = count + 1
          end

          if M.config.view == "notify" then
            M.notify(result, "success")
          elseif "float" then
            M.float(result)
          end
        end
      end,
    })
    :start()
end

return M
