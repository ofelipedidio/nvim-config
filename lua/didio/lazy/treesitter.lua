return {
    {
        "nvim-treesitter/nvim-treesitter",
        setup = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {"javascript", "rust", "java", "c", "lua", "vim" },
                sync_install = true,
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end
    }
}
