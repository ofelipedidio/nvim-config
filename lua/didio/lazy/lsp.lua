return {
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig",
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local lspconfig = require('lspconfig')
            local cmp_nvim_lsp = require('cmp_nvim_lsp')

            vim.diagnostic.config({
                update_on_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
                virtual_text = true,
            })

            local opts = { noremap = true, silent = true }
            local on_attach = function(_, bufnum)
                opts.buffer = bufnum

                -- Go to
                opts.desc = 'Go to declaration'
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                opts.desc = 'Go to definition'
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                opts.desc = 'Go to implementation'
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

                -- Info
                opts.desc = 'Show documentation for what is under cursor'
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                opts.desc = 'View workspace symbol'
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                opts.desc = 'View diagnostics'
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                opts.desc = 'Jump to the next diagnostic'
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                opts.desc = 'Jump to the previous diagnostic'
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                opts.desc = 'See available code actions'
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                opts.desc = 'View references'
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                opts.desc = 'Rename'
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                opts.desc = 'Show help'
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

                -- I want to check these out
                opts.desc = ''
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                opts.desc = 'Go to type definition'
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            end

            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- lspconfig['rust-analyzer'].setup({
            --     capabilities = capabilities,
            --     on_attach = on_attach,
            -- })

            lspconfig["lua_ls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = { -- custom settings for lua
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            })

            lspconfig["clangd"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig["gopls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                }
            })
        end
    },
}
