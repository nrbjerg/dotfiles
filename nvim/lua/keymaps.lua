
------------------------
--  General Mappings  --
------------------------

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", {})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------
-- Normal Mode --
-----------------
-- Mappings for splits
keymap("n", "<C-h>", "<C-w>h", {})
keymap("n", "<C-j>", "<C-w>j", {})
keymap("n", "<C-k>", "<C-w>k", {})
keymap("n", "<C-l>", "<C-w>l", {})

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Mappings for scrolling up And down
keymap ("n", "<A-k>", "<C-u>k", {})
keymap ("n", "<A-j>", "<C-d>j", {})

-- TAB SHIFT-TAB will go back
keymap("n", "<TAB>", ":bnext<CR>", {})
keymap("n", "<S-TAB>", ":bprevious<CR>", {})

-- Nvim Comment
keymap("n", "<leader>c", ":CommentToggle<CR>", {})       -- Comment One Line
keymap("x", "<leader>c", ":'<,'>CommentToggle<CR>", {})  -- Comment Multiple Lines In Visual Mode

-- Telescope 
keymap("n", "<leader>.", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>f", ":Telescope live_grep<CR>", opts)
-- Don't accidently create macros when trying to quit
keymap('n', 'Q', 'q', {})
keymap('n', 'q', '<nop>', {})

-- Toggle NvimTree
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", {})

-- Terminal
keymap("n", "<leader>t", ":vnew term://zsh<CR>", {})

-- Yank entire line
keymap ("n", "yie", ":<C-u>%y<CR>", {})

-- Packer Commands
keymap("n", "<leader>pu", ":PackerUpdate<CR>", {})
keymap("n", "<leader>ps", ":PackerSync<CR>", {})
keymap("n", "<leader>pi", ":PackerInstall<CR>", {})

-----------------
-- Insert Mode --
-----------------
-- Map Escape Key To KJ
keymap("i", "kj", "<ESC>", {})
keymap("i", "jk", "<ESC>", {})

-- Fix One [Car] behind
keymap ("i", "<Esc>", "<Esc>`^", {})

-- center screen after search
vim.cmd([[
nnoremap n nzzzv
nnoremap N Nzzzv
]])

-- Auto Pairs TOODO: Load auto pairs plugin
vim.cmd([[
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>0
inoremap {;<CR> {<CR>};<ESC>0
nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap " ""<left>
inoremap ' ''<left>
]])

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
