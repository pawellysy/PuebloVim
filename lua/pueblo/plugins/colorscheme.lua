return {

    "folke/tokyonight.nvim",
    event = 'VeryLazy',
    opts = { style = "moon" },
    priority = 1000,
    config = function ()
        vim.cmd.colorscheme('tokyonight')
    end

}
