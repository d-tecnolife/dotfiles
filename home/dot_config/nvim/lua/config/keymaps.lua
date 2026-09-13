-- Loaded on the VeryLazy event, after LazyVim's default keymaps, so these
-- replace the defaults on the keys they share.

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = true })
end

map("i", "jk", "<Esc>")
map("i", "<Esc>", "<Nop>")

map("n", "<leader>ff", function()
  Snacks.picker.files({ cwd = "~/" })
end, "Find Files")
map("n", "<leader>fg", function()
  Snacks.picker.grep()
end, "Grep")
map("n", "<leader>fc", function()
  Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") })
end, "Find Config File")

map("n", "<leader>m", "<cmd>Mason<cr>", "Mason")
map("n", "<leader>sr", function()
  require("persistence").load({ last = true })
end, "Restore Session")
map("n", "<leader>tt", "<cmd>TodoTrouble<cr>", "Todo Trouble")
map("n", "<leader>z", function()
  require("zen-mode").toggle()
end, "Zen Mode")

-- The claudecode extra supplies the other <leader>a Claude Code mappings.
map("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", "Claude Model")

if vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1 then
  map("n", "<leader>pv", "<cmd>VenvSelect<cr>", "Python Venv")
end
