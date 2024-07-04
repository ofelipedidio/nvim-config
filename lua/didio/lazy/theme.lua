return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                variant = 'moon',
            })

		    -- vim.cmd("colorscheme rose-pine")
		    -- vim.cmd("set termguicolors")
        end
    },
    {
	    "briones-gabriel/darcula-solid.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
        },
	    config = function()
		    -- vim.cmd("colorscheme darcula-solid")
		    -- vim.cmd("set termguicolors")
	    end
    },

    {
        'kepano/flexoki-neovim',
        name = 'flexoki',
        config = function()
		    vim.cmd("colorscheme flexoki-dark")
		    vim.cmd("set termguicolors")
        end
    },

    -- Default colorschemes (that are good)
    -- vim.cmd("colorscheme habamax")
    -- vim.cmd("colorscheme slate")
}

