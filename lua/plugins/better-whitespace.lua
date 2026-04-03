return {
    "ntpeters/vim-better-whitespace",
    config = function()
        vim.g.better_whitespace_enabled = 1
        vim.g.strip_whitespace_on_save = 1
        vim.g.strip_only_modified_lines = 0
        vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#1E90FF" })
    end,
    event = "BufReadPre"
}
