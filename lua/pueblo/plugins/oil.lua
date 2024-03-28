return {
    "stevearc/oil.nvim",
    opts = {},
    config = function()
        require("oil").setup()
        -- require('pueblo.utils').load_mappings('oil')
    end
}
