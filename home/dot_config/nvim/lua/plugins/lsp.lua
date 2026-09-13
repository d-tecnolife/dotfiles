return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
        severity_sort = true,
        float = { border = "rounded" },
        virtual_text = { source = "if_many", spacing = 2 },
      })

      opts.servers = opts.servers or {}
      opts.servers.lua_ls = vim.tbl_deep_extend("force", opts.servers.lua_ls or {}, {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            diagnostics = { globals = { "vim", "Snacks" } },
            telemetry = { enable = false },
            workspace = { checkThirdParty = false },
          },
        },
      })

      -- PowerShell Editor Services runs on pwsh; skip it where pwsh is absent.
      if vim.fn.executable("pwsh") == 1 then
        opts.servers.powershell_es = {
          bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
        }
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      default_format_opts = { timeout_ms = 750 },
      formatters_by_ft = {
        python = { "ruff_format", "isort" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        rust = { "rustfmt" },
        sh = { "shfmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local linters_by_ft = {
        ansible = { "ansible_lint" },
        dockerfile = { "hadolint" },
        javascript = { "eslint_d", "eslint" },
        markdown = { "markdownlint" },
        python = { "ruff", "mypy" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
      }
      opts.linters_by_ft = vim.tbl_extend("force", opts.linters_by_ft or {}, linters_by_ft)
      opts.linters = opts.linters or {}

      -- Run a linter only where its executable exists, so machines without it
      -- stay quiet instead of reporting a failed spawn on every save.
      for _, names in pairs(linters_by_ft) do
        for _, name in ipairs(names) do
          opts.linters[name] = vim.tbl_extend("force", opts.linters[name] or {}, {
            condition = function()
              local linter = require("lint").linters[name]
              if type(linter) == "function" then
                linter = linter()
              end
              local cmd = linter and linter.cmd
              if type(cmd) == "function" then
                cmd = cmd()
              end
              return type(cmd) == "string" and vim.fn.executable(cmd) == 1
            end,
          })
        end
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "dockerfile",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "powershell",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}
