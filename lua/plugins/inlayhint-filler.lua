return {
    "Davidyz/inlayhint-filler.nvim",
    keys = {
        {
            "<leader>i",
            function()
                require("inlayhint-filler").fill()
            end,
            desc = "Fill Inlay Hint",
            mode = "n",
        }
    },
}
