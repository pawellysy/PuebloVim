return {
    "simrat39/symbols-outline.nvim",
    event = "VeryLazy",

    config = function()
        require('pueblo.utils').load_mappings('symbolsoutline')
        require("symbols-outline").setup()
    end,
}
