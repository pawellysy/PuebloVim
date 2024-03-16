return {
    'backdround/global-note.nvim',
    config = function ()
        require('global-note').setup();
        require('pueblo.utils').load_mappings('globalnote');
    end
}
