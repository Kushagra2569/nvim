vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

return {
  {
    "xiyaowong/transparent.nvim",
    config = function(_)
      local transparent = require("transparent")
      transparent.setup({
        groups = { -- table: default groups
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLineNr",
          "EndOfBuffer",
        },
        extra_groups = {
          "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
          "NvimTreeNormal",
        }, -- table: additional groups that should be cleared
        exclude_groups = {}, -- table: groups you don't want to clear
      })
    end,
  },
  {
    "github/copilot.vim",
  },
  {
    "numToStr/FTerm.nvim",
    opts = {
      cmd = '"C:\\Program Files\\PowerShell\\7\\pwsh.exe"',
      border = "none",
      hl = "TabLine",
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
    },
  },
  {
    "AlexvZyl/nordic.nvim",
    priority = 1000,
    config = function()
      require("nordic").setup({ -- can also use require("config.nordic") to call nordic file under config folder for bigger configs
        swap_backgrounds = true,
      })
    end,
    lazy = true,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordic",
    },
  },
  { "notken12/base46-colors" },
  {
    "Shatur/neovim-ayu",
  },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
}
