return {

    "folke/tokyonight.nvim",
    -- lazy = 'false',
    event = "VimEnter",
    opts = { style = "moon" },
    priority = 1000,
    config = function (opts)
        vim.cmd.colorscheme('tokyonight')
        require("tokyonight").setup(opts)
    end
}
