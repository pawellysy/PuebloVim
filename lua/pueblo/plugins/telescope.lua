return {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' , {'nvim-telescope/telescope-fzy-native.nvim', build = 'make'} },
    config = function (opts)
        local telescope = require('telescope');
        telescope.setup {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        }
        -- telescope.load_extension('fzf')
        require('pueblo.utils').load_mappings('telescope')
    end
}
