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
    opts = {
        window = {
            position = 'right'
        },

        filesystem = {
            hide_dotfiles = false,
            bind_to_cwd = false,
            follow_current_file = { enabled = true }
        }
    },
    keys = {
        { "<leader>e", "<cmd>Neotree<CR>", desc = "Toggle neotree", remap = true },
    },
    config = function(_, opts)

        require("neo-tree").setup(opts)
    end,
}
