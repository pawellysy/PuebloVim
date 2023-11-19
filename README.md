### PuebloVim configuration of Neovim


#### Currently WIP.

The keymaps are based on NvChad and LazyVim distros.
To add new plugin, create new file in lua/pueblo/plugings dir and return its config tu lazy.nvim package manager.

keymaps are defined in the `lua/pueblo/mappings.lua` file. To add the plugin-specific plugin, in the plugin setup method add `require('pueblo.util').load_mappings(< packagename >)
