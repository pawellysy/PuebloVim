return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzy-native.nvim', build = 'make' },
        "sharkdp/fd"
    },
    config = function(opts)
        local telescope = require('telescope');
        telescope.setup {
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        }
        telescope.load_extension('fzy_native')
        require('pueblo.utils').load_mappings('telescope')
    end
}
