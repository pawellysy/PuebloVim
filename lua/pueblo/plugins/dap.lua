  return {
  "mfussenegger/nvim-dap",
  dependencies = {
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',
    'mxsdev/nvim-dap-vscode-js'
  },
  config = function()
    local dap = require("dap")
    local dapwidgets = require('dap.ui.widgets')
    local dapui = require("dapui")
    local dapvscode = require("dap-vscode-js")
    local dapextcode = require('dap.ext.vscode')
    local dapvirtualtext = require("nvim-dap-virtual-text")
    
    dapui.setup()
    dapvirtualtext.setup()

    -- define keymap for dap
    -- define listeners to open/close dapui automatically
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    dapvscode.setup({
      debugger_path = require('mason-registry').get_package('js-debug-adapter'):get_install_path(),
      debugger_cmd = { "js-debug-adapter" },
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
      log_file_path = require('mason-registry').get_package('js-debug-adapter'):get_install_path() .. "/dap_vscode_js.log", -- Path for file logging
      log_file_level = vim.log.levels.DEBUG, -- Logging level for output to file. Set to false to disable file logging.
      log_console_level = vim.log.levels.DEBUG -- Logging level for output to console. Set to false to disable console output.
    })

    -- We need to redefine pwd-node adapter due some issue with vscode-js-debug
    -- See: https://github.com/mxsdev/nvim-dap-vscode-js/issues/42
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        -- If vscode-js-debug is installed with mason it is in the path 
        command = "js-debug-adapter",
        args = {"${port}"},
        }
    }

    -- Load .vscode/launch.json file and associate all "node" configurations to typescript and javascript filetypes
    if vim.loop.fs_stat('.vscode/launch.json') then
      dapextcode.load_launchjs(nil, {
        node = {'typescript', 'javascript'}
      })
      -- ensure all configurations are pwa-node to work properly with dap-vscode-js
      for i,config in ipairs(dap.configurations.typescript) do
        config["type"] = "pwa-node"
      end
    end

  end
}
