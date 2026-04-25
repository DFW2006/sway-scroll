---@diagnostic disable: undefined-global
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Run current Python file in a floating terminal
vim.keymap.set("n", "<leader>rp", function()
  local file = vim.fn.expand("%:p")
  local dir = vim.fn.expand("%:p:h")
  -- The '\"' adds quotes so spaces in folder names don't break things
  require("snacks").terminal.open(
    "python3 " .. '"' .. file .. '"' .. "; read -p 'Press enter to close...' ",
    { cwd = dir }
  )
end, { desc = "Run Python File" })
