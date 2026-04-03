return {
{
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
        -- setup options fo here
        flavour = "Macchiato",
    },
    config = function()
        vim.cmd.colorscheme("catppuccin")
    end,
},

}
