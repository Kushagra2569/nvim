return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "clangd",
        "rust-analyzer",
        "gopls",
        "typescript-language-server",
        "tailwindcss-language-server",
        "svelte-language-server",
        -- python
        "ruff-lsp", -- lsp
        "ruff", -- linter (but used as formatter)
        "pyright", -- lsp
        "black", -- swift
        "mypy", -- linter
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "c",
        "rust",
        "javascript",
        "python",
        "go",
        "svelte",
        "css",
        "swift",
      })
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "simrat39/rust-tools.nvim",
    },
    opts = {
      servers = {
        rust_analyzer = {},
      },
      setup = {
        rust_analyzer = function(_, opts)
          require("rust-tools").setup({ server = opts })
          return true
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        gopls = {
          cmd = { "gopls" },
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        },
        tailwindcss = {},
        pyright = {
          filetypes = { "python" },
        },
        sourcekit = {
          cmd = { "xcrun", "sourcekit-lsp" },
          filetypes = { "swift", "objective-c", "objective-cpp" },

          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            if fname == "" then
              on_dir(nil)
              return
            end

            local startpath = vim.fs.dirname(fname)

            local function find(pattern)
              local match = vim.fs.find(pattern, { path = startpath, upward = true })[1]
              return match and vim.fs.dirname(match) or nil
            end

            local root = find(".buildServer.json")
              or find("*.xcworkspace")
              or find("*.xcodeproj")
              or find("Package.swift")
              or find(".git")

            on_dir(root)
          end,
        },
      },
    },
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      -- replace `prettier` with `prettierd` first
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs({
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "html",
        "css",
        "json",
        "markdown",
      }) do
        opts.formatters_by_ft[ft] = { "prettierd", "prettier" }
      end

      -- ensure the `prettierd` formatter is defined
      opts.formatters = opts.formatters or {}
      opts.formatters.prettierd = {
        -- only activate if the daemon is available
        condition = function()
          return vim.fn.executable("prettierd") == 1
        end,
      }
    end,
  },
}
