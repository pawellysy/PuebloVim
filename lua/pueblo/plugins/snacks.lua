return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        local opts = {
            bigfile   = { enabled = true },
            dashboard = { enabled = false },
            indent    = { enabled = true },
            input     = { enabled = false },
            notifier  = { enabled = true },
            notify    = { enabled = true },
            quickfile = { enabled = true },
            scroll    = { enabled = false },
            scratch   = { enabled = true },
            scope     = { enabled = true },
            words     = { enabled = true },
        }
        require("snacks").setup(opts)
        require("pueblo.utils").load_mappings("snacks")
    end
}
