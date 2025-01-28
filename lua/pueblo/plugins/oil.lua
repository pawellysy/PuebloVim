return {
    "stevearc/oil.nvim",
    opts = {},
    event = "VeryLazy",
    config = function()
        require("oil").setup()
        require('pueblo.utils').load_mappings('oil')
    end
}
