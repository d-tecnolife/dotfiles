-- Built in Lua rather than with bash, which Windows does not have on PATH.
local user = vim.env.USER or vim.env.USERNAME or "user"
local host = (vim.uv or vim.loop).os_gethostname()

return {
  width = 72,
  sections = {
    { padding = 1 },
    {
      align = "center",
      text = { ("[ %s@%s ]"):format(user, host), hl = "neon" },
      height = 2,
      padding = 0,
    },
    {
      align = "center",
      text = "you have no life.",
      height = 2,
      padding = 1,
    },
    {
      align = "center",
      padding = 1,
      text = {
        { "  [u]pdate ", hl = "Label" },
        { "  [f]iles ", hl = "DiagnosticInfo" },
        { "  [g]rep ", hl = "@property" },
        { "  [l]ast session ", hl = "Number" },
        { "  [m]ason ", hl = "@string" },
        { "  [c]onfig " },
      },
    },
    { title = "[p]rojects", section = "projects", padding = 1 },
    { title = "[r]ecent", section = "recent_files", limit = 3, padding = 1 },
    {
      section = "terminal",
      title = "git status",
      enabled = function()
        return Snacks.git.get_root() ~= nil
      end,
      cmd = "git --no-pager diff --stat -B -M -C",
      hl = "Statement",
      height = 5,
      padding = 1,
    },
    {
      text = { "[q]uit", hl = "DiagnosticError" },
      align = "center",
      padding = 1,
    },
    { hidden = true, text = "update", action = ":Lazy update", key = "u" },
    {
      hidden = true,
      text = "config",
      action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
      key = "c",
    },
    { hidden = true, text = "mason", action = ":Mason", key = "m" },
    { hidden = true, text = "files", action = ":lua Snacks.picker.files({ cwd = '~/' })", key = "f" },
    {
      hidden = true,
      text = "last session",
      action = ':lua require("persistence").load({ last = true })',
      key = "l",
    },
    {
      hidden = true,
      text = "projects",
      action = ":lua Snacks.picker.projects({ confirm = function(picker, item) picker:close() if item then vim.cmd('cd ' .. vim.fn.fnameescape(item.file)) Snacks.picker.files() end end })",
      key = "p",
    },
    { hidden = true, text = "recent", action = ":lua Snacks.picker.recent()", key = "r" },
    { hidden = true, text = "grep", action = ":lua Snacks.picker.grep()", key = "g" },
    { hidden = true, text = "quit", action = ":qa!", key = "q" },
  },
}
