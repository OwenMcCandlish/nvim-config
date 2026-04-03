-- Used to set settings

-- General Config
vim.o.fileencoding = "utf-8" -- make sure that encoding is always utf-8
vim.wo.number = true         -- Add line numbers
vim.o.wrap = false

-- TAB == 4 spaces
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

-- Color Setting
vim.o.termguicolors = true

-- Spell Checking
vim.o.spell = false

-- Case Insensitive Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Horizontal Scrolling
vim.o.sidescroll = 10
vim.opt.virtualedit = 'all'

-- Split Opens on right
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Fix Coloring of Treesitter Comments
vim.api.nvim_set_hl(0, "@lsp.type.comment", {})

