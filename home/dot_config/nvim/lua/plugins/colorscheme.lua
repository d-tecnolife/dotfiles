-- tokyonight follows the desktop's Light/Dark mode, which the Hyprland theme
-- scripts write to ~/.cache/.theme_mode. Without that file it stays on night.
local mode_file = vim.fn.expand("~/.cache/.theme_mode")

local function scheme()
  if vim.fn.filereadable(mode_file) == 1 and vim.trim(vim.fn.readfile(mode_file)[1] or "") == "Light" then
    return "tokyonight-day"
  end
  return "tokyonight-night"
end

return {
  { "folke/tokyonight.nvim", opts = { transparent = true } },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local group = vim.api.nvim_create_augroup("user-colorscheme", { clear = true })
        -- Reapplied on every colorscheme change so a Light/Dark switch keeps them.
        vim.api.nvim_create_autocmd("ColorScheme", {
          group = group,
          callback = function()
            vim.api.nvim_set_hl(0, "neon", { fg = "#00FF41" })
            vim.api.nvim_set_hl(0, "brightred", { fg = "#FF3131" })
          end,
        })
        vim.api.nvim_create_autocmd("FocusGained", {
          group = group,
          callback = function()
            local wanted = scheme()
            if vim.g.colors_name ~= wanted then
              vim.cmd.colorscheme(wanted)
            end
          end,
        })
        vim.cmd.colorscheme(scheme())
      end,
    },
  },
}
