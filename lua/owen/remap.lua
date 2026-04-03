-- General
vim.g.mapleader = " "
vim.keymap.set("i", "<C-c>", "<NOP>")
vim.keymap.set("v", "<C-c>", '"+y', {desc="Copy to system clipboard"})
vim.keymap.set("n", "<leader>s", "<cmd>StripWhitespace<CR>", { desc = "Strip trailing whitespace" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc="Scroll Up"})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc="Scroll Down"})

-- Windows
opts = {silent = true}

opts.desc = "Split window vertically"
vim.keymap.set("n", "<leader>%", vim.cmd.vsplit, opts)
opts.desc = "Split window horizontally"
vim.keymap.set("n", '<leader>"', vim.cmd.split, opts)
opts.desc = "Close window"
vim.keymap.set("n", "<leader>x", vim.cmd.q, opts)

-- Code Actions
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- Toggle Inline Hints
vim.keymap.set('n', '<leader>ti', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle Inlay Hints' })
-- Toggle Diagnostics
vim.keymap.set('n', '<leader>td', function()
    if vim.diagnostic.is_enabled() then
        vim.diagnostic.disable()
        print("Diagnostics Disabled")
    else
        vim.diagnostic.enable()
        print("Diagnostics Enabled")
    end
end, { desc = 'Toggle Diagnostics' })

-- Close any window with esc
function close_floats()
    if require("mini.files").close() then
        return
    end
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative == "win" then
            vim.api.nvim_win_close(win, false)
        end
    end
end

vim.keymap.set("n", "<Esc>", close_floats)

-- Horizontal Scrolling
vim.keymap.set({"n", "x"}, "<M-p>", "5zh")
vim.keymap.set({"n", "x"}, "<M-n>", "5zl")

-- Window Resize
vim.keymap.set({"n"}, "<M-H>", "<Cmd>5wincmd<LT><CR>")
vim.keymap.set({"n"}, "<M-L>", "<Cmd>5wincmd><CR>")
vim.keymap.set({"n"}, "<M-J>", "<Cmd>5wincmd-<CR>")
vim.keymap.set({"n"}, "<M-K>", "<Cmd>5wincmd+<CR>")

-- Convert 2-space indentation to 4-space
vim.keymap.set('n', '<leader>t4', ':set ts=2 sts=2 noet | retab! | set ts=4 sts=4 et | retab<CR>', {
    noremap = true,
    silent = true,
    desc = "Indent: Convert 2 spaces to 4"
})

-- Convert 4-space indentation to 2-space
vim.keymap.set('n', '<leader>t2', ':set ts=4 sts=4 noet | retab! | set ts=2 sts=2 et | retab<CR>', {
    noremap = true,
    silent = true,
    desc = "Indent: Convert 4 spaces to 2"
})
