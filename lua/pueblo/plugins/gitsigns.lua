return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        require('gitsigns').setup()
        require('pueblo.utils').load_mappings('gitsigns')
    end
}
