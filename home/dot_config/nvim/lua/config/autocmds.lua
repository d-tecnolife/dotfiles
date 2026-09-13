-- Loaded on the VeryLazy event. LazyVim already maps gd, gD, gr, K and
-- <leader>ca on LSP attach and lints on write; these add the rest.

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp", { clear = true }),
  callback = function(event)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc, silent = true })
    end

    map("gi", vim.lsp.buf.implementation, "Goto Implementation")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>f", function()
      require("conform").format({ async = true, lsp_format = "fallback" })
    end, "Format")
  end,
})
