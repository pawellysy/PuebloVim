return {
    'barrett-ruth/live-server.nvim',
    build = 'yarn global add live-server',
    config = true,
    setup = function()
        require('live-server').setup()
    end,

}
