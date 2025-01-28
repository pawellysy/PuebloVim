return {
    'ThePrimeagen/harpoon',
    config = function ()
        require('harpoon').setup()
        require('pueblo.utils').load_mappings('harpoon')
    end
}
