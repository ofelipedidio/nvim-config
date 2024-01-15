-- Setup leader
vim.g.mapleader = " "

-- Setup lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("didio.lazy", {
  change_detection = {
    enabled = true,
    notify = false,
  },
})

-- Load configs
require('didio')

--[[
require("lazy").setup({
    -- treesitter
    "nvim-treesitter/nvim-treesitter-context",

    -- Autocompletion

    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "VonHeikemen/lsp-zero.nvim",
    "nvim-treesitter/nvim-treesitter",
}, {})

--]]
