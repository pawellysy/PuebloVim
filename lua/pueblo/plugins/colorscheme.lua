return {

    "folke/tokyonight.nvim",
    event = 'VeryLazy',
    opts = { style = "moon" },
    config = function ()
        vim.cmd.colorscheme('tokyonight')
    end

}
