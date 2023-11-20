return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = function()
      require("pueblo.utils").load_mappings "trouble"
    end,
        opts = {},
      }
