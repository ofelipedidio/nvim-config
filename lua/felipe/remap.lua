vim.g.mapleader = " "

-- Exit from file
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines around on visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- J does not move the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Center cursor and unfold folded code
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Exit interactive mode with Ctrl+C
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Ctrl+U and Ctrl+D center the screen
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Greatest remap ever (delete into black hole register and paste)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Next greatest remap ever : asbjornHaland (Yank into clipboard)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Increase number (on Tmux)
vim.keymap.set({"n", "v"}, "<leader><leader>a", "<C-a>")

-- Delete into black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Format file
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Jump to next/previous error
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Jump to next/previous quickfix
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


