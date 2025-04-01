return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile   = { enabled = true },
        dashboard = { enabled = false },
        indent    = { enabled = true },
        input     = { enabled = false },
        notifier  = { enabled = true },
        quickfile = { enabled = true },
        scroll    = { enabled = false },
        scratch   = { enabled = true },
        scope     = { enabled = true },
        words     = { enabled = true },
    },
    config = function()
        vim.notify("autocommand added!")
        vim.api.nvim_create_autocmd("BufAdd", {
            callback = function()
                vim.notify("Buffer added!")
            end,
        })

        require("snacks").setup()
        require("pueblo.utils").load_mappings("snacks")
    end
}
