-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<leader>pv", "<Cmd>Neotree toggle<CR>")

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")

vim.keymap.set("n", "<leader>[", "<cmd>bprevious<cr>", {
  desc = "Switch buffer left by one",
})

vim.keymap.set("n", "<leader>]", "<cmd>bnext<cr>", {
  desc = "Switch buffer right by one",
})

vim.keymap.set("n", "<leader>T", "<cmd>enew<cr>", {
  desc = "Creates new buffer",
})

vim.keymap.set("n", "<leader>W", "<cmd>bd<cr>", {
  desc = "Deletes new buffer",
})
