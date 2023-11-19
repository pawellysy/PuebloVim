return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
        { "<leader>e", "<cmd>Neotree<CR>", desc = "show Tree Structure", remap = true },
    },
    config = function(_, opts)

        require("neo-tree").setup(opts)
    end,
}
