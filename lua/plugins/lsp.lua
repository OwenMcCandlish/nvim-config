-- Configures 'K' key to show diagnostics when available but
-- regular hover info when not
function float_menu_mux(key_to_map, opts)
  vim.keymap.set('n', key_to_map, function()
    -- Get current cursor position (0-indexed)
    local cursor_line = vim.fn.line(".") - 1
    local cursor_col = vim.fn.col(".") - 1

    -- Get all diagnostics for the current line
    local line_diagnostics = vim.diagnostic.get(0, { lnum = cursor_line })

    local has_diagnostic_at_cursor = false
    -- Iterate through the diagnostics on the current line
    for _, d in ipairs(line_diagnostics) do
      -- A diagnostic's range is [d.col, d.end_col) (inclusive start, exclusive end).
      -- We check if the cursor's column is within this range.
      if d.end_col and cursor_col >= d.col and cursor_col < d.end_col then
        has_diagnostic_at_cursor = true
        break -- Found a diagnostic at the cursor, no need to check further
      end
    end

    if has_diagnostic_at_cursor then
      -- Open the float. By default, it opens for the diagnostic at the cursor.
      vim.diagnostic.open_float({ border = "rounded", focusable = false })
    else
      -- No diagnostic under the cursor, show regular hover info
      vim.lsp.buf.hover({border = "rounded"})
    end
  end, opts)
end

return {
-- Mason: Used to insall lsp's and other things
{
    "mason-org/mason.nvim",
    opts = {},
},

-- mason-lspconfig: connects lspconfig with mason
{
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {"lua_ls", "clangd", "ruff"},
        -- automatic_enable = true,
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    }

},

-- lspconvig: has defualt lsp configs.
{
    "neovim/nvim-lspconfig",
    dependencies = {
        "nvim-telescope/telescope.nvim"
    },
    config = function()
        vim.diagnostic.config({virtual_text = false})

        local keymap = vim.keymap

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
                local opts = {buffer = ev.buf, silent = true}
                local builtin = require("telescope.builtin")

                -- go to definition
                opts.desc = "Go to definition (Telescope)"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "Go to definition in new vertical split (Telescope)"
                keymap.set("n", "gDl", function()
                    builtin.lsp_definitions({jump_type = "vsplit"})
                end, opts)

                opts.desc = "Go to definition in new horizontal split (Telescope)"
                keymap.set("n", "gDj", function()
                    builtin.lsp_definitions({jump_type = "split"})
                end, opts)

                -- go to declaration
                opts.desc = "Go to declaration (Telescope)"
                keymap.set("n", "gf", vim.lsp.buf.declaration, opts)
                opts.desc = "Go to declaration"
                keymap.set("n", "gF", vim.lsp.buf.declaration, opts)

                -- go to implementation
                opts.desc = "Go to implementation (Telescope)"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                opts.desc = "Go to implementation"
                keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)

                -- reference search
                opts.desc = "Reference search"
                keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

                -- show diagnositcs mux thing
                opts.desc = "Show hover"
                float_menu_mux("K", opts)

                -- show code actions
                opts.desc = "Show code actions"
                keymap.set("i", "<C-.>", vim.lsp.buf.code_action, opts)

                -- jump to previous diagnostic in buffer
                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                -- jump to next diagnostic in buffer
                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            end
        })

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        vim.lsp.config('*', {
          capabilities = {
              general = {
                  positionalEncodings = {"utf-8"}
              }
          }
        })

        vim.lsp.config('clangd', {
            filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "cu"},
        })

        -- enable inlay hint
        vim.lsp.inlay_hint.enable(true, {0})
    end
},
}
