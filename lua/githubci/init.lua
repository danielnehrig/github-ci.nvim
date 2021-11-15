local M = {}

M.defaults = {
  success = "✔️",
  failure = "❌",
  pending = "🟠",
  view = "notify",
}

M.config = {}

function M.setup(opt)
  M.config = vim.tbl_deep_extend("force", {}, M.defaults, opt or {})
  vim.api.nvim_exec(
    [[
  command! GithubCI lua require('githubci').ci()
  ]],
    false
  )
end

function M.notify(msg, type)
  local notify = require("notify")

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
        end

        if M.config.view == "notify" then
          M.notify(result, "success")
        elseif "float" then
          M.float(result)
        end
      end,
    })
    :start()
end

return M
