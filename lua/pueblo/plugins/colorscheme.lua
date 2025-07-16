return {
    {
        "folke/tokyonight.nvim",
        config = function()
            local val = "wr"
            require("tokyonight").setup({
                style = "night",
                on_highlights = function(hl)
                    hl.WinSeparator = { fg = "#00FF00", bg = "NONE", bold = true }
                    hl.Comment = { fg = "#AAAAAA", italic = true }
                    hl.NormalNC = {
                        fg = "#a0a0a0",
                        bg = "#1e1e1e"
                    }
                end,
            })

            vim.cmd.colorscheme('tokyonight')
        end
    }
}
