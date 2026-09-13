-- Loaded before lazy.nvim starts, after LazyVim's default options.

vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.opt.wrap = true

-- Format with Prettier even in projects without a Prettier config file.
vim.g.lazyvim_prettier_needs_config = false
