### PuebloVim configuration of Neovim


#### Currently WIP.
TODO:
Configure DAP
Fix formatting the selected part. 


##### Adding new plugins
To add new plugin, create new file in `lua/pueblo/plugings` dir and return its config to lazy.nvim package manager.

#### Adding keymaps
The keymaps are based on NvChad and LazyVim distros.
keymaps are defined in the `lua/pueblo/mappings.lua` file. To add the plugin-specific plugin, in the plugin setup method add `require('pueblo.util').load_mappings(< packagename >)
