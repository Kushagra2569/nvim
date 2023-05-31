-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<ESC>", { nowait = true })
vim.keymap.set("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
vim.api.nvim_create_user_command("FTermOpen", require("FTerm").open, { bang = true })
vim.api.nvim_create_user_command("FTermToggle", require("FTerm").toggle, { bang = true })
vim.api.nvim_create_user_command("FTermExit", require("FTerm").exit, { bang = true })
vim.api.nvim_create_user_command("FTermClose", require("FTerm").close, { bang = true })
