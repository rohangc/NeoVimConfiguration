-- Emulate Windows behaviour also for cut/copy/paste
local nvim_version = vim.version()
if nvim_version.major == 0 and nvim_version.minor <= 10 then
    vim.cmd("source $VIMRUNTIME/mswin.vim")
else
    vim.cmd("source $VIMRUNTIME/scripts/mswin.vim")
end

-- Load global options
require('config.options')

-- Load the lazy.nvim plugin manager
require('config.lazy')
