return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require"fzf-lua".setup({"telescope",winopts={preview={default="bat"}}})
        require('pueblo.utils').load_mappings('telescope')
    end
}
