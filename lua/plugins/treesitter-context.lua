return {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
        enable = true,
        multiwindow = true,
    },
    keys = {"<leader>tc", "<cmd> TSContext toggle <CR>", desc={"Toggle Context"}}
}

