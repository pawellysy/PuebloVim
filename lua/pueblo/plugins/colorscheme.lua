return {
    {
        "folke/tokyonight.nvim",
        -- event = "VimEnter",
        -- enabled = false,
        config = function ()
            require("tokyonight").setup({
                -- transparent = true,
                style = "night",
                on_highlights = function(hl, c)
                    local prompt = "#2d3149"
                    hl.TelescopeNormal = {
                        bg = c.bg_dark,
                        fg = c.fg_dark,
                    }
                    hl.TelescopeBorder = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopePromptNormal = {
                        bg = prompt,
                    }
                    hl.TelescopePromptBorder = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePromptTitle = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePreviewTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopeResultsTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                end,
            })

            -- vim.cmd.colorscheme('tokyonight')
        end
    }, {
        "catppuccin/nvim",
        event = "VimEnter",
        name = "catppuccin",
        priority = 1000,
        config = function ()
            require('catppuccin').setup()
            -- vim.cmd.colorscheme('catppuccin')
        end
    },
    {
        "aktersnurra/no-clown-fiesta.nvim",
        event = "VimEnter",
        priority = 1001,
        name = "no-clown-fiesta",
        config = function ()
            require('no-clown-fiesta').setup()
            vim.cmd.colorscheme('no-clown-fiesta')
        end

    }
}
