return {

    "folke/tokyonight.nvim",
    -- lazy = 'false',
    event = "VimEnter",
    opts = { style = "moon" },
    priority = 1000,
    config = function (opts)
        vim.cmd.colorscheme('tokyonight')
        require("tokyonight").setup(opts)
        --     on_highlights = function(hl, c)
        --         local prompt = "#2d3149"
        --         hl.TelescopeNormal = {
        --             bg = c.bg_dark,
        --             fg = c.fg_dark,
        --         }
        --         hl.TelescopeBorder = {
        --             bg = c.bg_dark,
        --             fg = c.bg_dark,
        --         }
        --         hl.TelescopePromptNormal = {
        --             bg = prompt,
        --         }
        --         hl.TelescopePromptBorder = {
        --             bg = prompt,
        --             fg = prompt,
        --         }
        --         hl.TelescopePromptTitle = {
        --             bg = prompt,
        --             fg = prompt,
        --         }
        --         hl.TelescopePreviewTitle = {
        --             bg = c.bg_dark,
        --             fg = c.bg_dark,
        --         }
        --         hl.TelescopeResultsTitle = {
        --             bg = c.bg_dark,
        --             fg = c.bg_dark,
        --         }
        --     end,
        -- })
    end

}
