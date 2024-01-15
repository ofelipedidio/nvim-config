return {
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim",
            "j-hui/fidget.nvim",
            {
                "hrsh7th/nvim-cmp",
                dependencies = {
                    'neovim/nvim-lspconfig',
                    'hrsh7th/cmp-nvim-lsp',
                    'hrsh7th/cmp-buffer',
                    'hrsh7th/cmp-path',
                    'hrsh7th/cmp-cmdline',
                    'hrsh7th/nvim-cmp',
                    "L3MON4D3/LuaSnip",
                }
            }
        },
        config = function()
            require("fidget").setup({})
            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                },
                handlers = {
                    function (server_name)
                        require("lspconfig")[server_name].setup {}
                    end
                }
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local opts = {buffer = ev.buf, remap = false}

                    -- Go to
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

                    -- Info
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

                    -- I want to check these out
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)

                    -- vim.keymap.set('n', '<space>f', function()
                    --     vim.lsp.buf.format { async = true }
                    -- end, opts)
                end,
            })

            local cmp = require'cmp'

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
                    ['<C-n>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    -- I want to try these out
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-c>'] = cmp.mapping.abort(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                })
            })

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
        end
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            print(ls)
            vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-l>", function() ls.jump( 1) end, {silent = true})

            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {silent = true})
        end,
    }

}
