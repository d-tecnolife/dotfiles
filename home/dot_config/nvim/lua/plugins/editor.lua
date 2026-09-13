-- The notes vault lives at ~/notes; obsidian.nvim loads only where it exists.
local notes = vim.fn.expand("~/notes")

return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    cond = vim.fn.isdirectory(notes) == 1,
    opts = {
      legacy_commands = false,
      workspaces = {
        { name = "notes", path = notes },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {},
  },
  {
    "saghen/blink.cmp",
    opts = {
      fuzzy = { implementation = "lua" },
    },
  },
}
