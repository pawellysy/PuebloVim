return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                style = "night",
                on_highlights = function(hl)
                    hl.WinSeparator = { fg = "#000000", bg = "NONE", bold = true }
                end,
            })

            vim.cmd.colorscheme('tokyonight')
        end
    }
}
