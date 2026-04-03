return {
    'echasnovski/mini.files',
    version = false,
    opts = {
        -- mappings = {
        --     close = "<Esc>"
        -- }
    },
    config = function()
        -- Toggle the editor
        vim.keymap.set( "n", "<leader>e",
            function()
                if not require("mini.files").close() then require("mini.files").open() end
            end,
            {desc = "Toggle file explorer"}
        )

        -- Esc to close
        vim.keymap.set("n", "<Esc>", require("mini.files").close, { desc = "Close file explorer" })
    end
}

