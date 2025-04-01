return {
    "stevearc/oil.nvim",
    opts = {},
    event = "VeryLazy",
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true
            }
        })
        require('pueblo.utils').load_mappings('oil')
    end
}
