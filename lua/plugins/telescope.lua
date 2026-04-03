-- A "smart" grep function that uses the visual selection if available.
local function smart_grep_string()
    local selection = ""

    local current_mode = vim.api.nvim_get_mode().mode

    -- Check if we are in any visual mode ('v', 'V', or blockwise)
    if current_mode == 'v' or current_mode == 'V' or current_mode == '' then
        -- Yank the visually selected text into the 'v' register.
        -- 'noau' prevents autocommands, 'normal!' uses default keybindings.
        vim.cmd('noau normal! "vy"')
        selection = vim.fn.getreg('v')
    end

    -- If the selection is not empty, use it as the search query.
    if selection ~= nil and vim.fn.trim(selection) ~= "" then
        require('telescope.builtin').grep_string({ search = selection })
    else
        -- Otherwise, open grep_string with no default query (normal behavior).
        vim.keymap.set('n', '<leader>ps', function()
            require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
        end)
        -- require('telescope.builtin').grep_string()
    end
end

return {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.1.9',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" }
    },
    opts = {
        defaults = {
            file_ignore_patterns = {
                "%.git/",
                "%.venv/",
                "__pycache__",
                "extern/"
            },
            pickers = {
                find_files = {
                    hidden = true, -- show hidden files
                }
            }
        },
        extensions = {
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        },
    },
    config = function()
        local builtin = require('telescope.builtin')
        -- keymaps
        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Find files in project' })
        vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = "Find open buffer"})
        vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = 'Find files in git' })
        vim.keymap.set({'n', 'v'}, '<leader>ps', smart_grep_string, { desc = 'Search files for a string' })

        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})


        require('telescope').load_extension('fzf')
    end

}

