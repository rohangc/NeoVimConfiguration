-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

if vim.fn.has('win32') or vim.fn.has('win64') then
    vim.opt.rtp:append(vim.fn.expand('~/nvim'))
    --vim.opt.rtp:append(vim.fn.expand('~/nvim/after'))
else
    vim.opt.rtp:append(vim.fn.expand('~/.config/nvim'))
    --vim.opt.rtp:append(vim.fn.expand('~/.config/nvim/after'))
end

-- Show diagnostic messages *also* in a hover window
--
-- Manually by pressing '\e' in normal mode or by simply hover the cursor over the
-- offending line
vim.diagnostic.config({
    virtual_text = {
        prefix = '●', -- Could be '■', '▎', 'x'
    },
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        show_header = true,
        source = "always",  -- Or "if_many"
        border = "rounded",
    },
})

vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- When searching try to be smart about cases 
vim.opt.smartcase = true

-- My preferred settings
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.backup = false
vim.opt.list = false
vim.opt.undofile = false
vim.opt.writebackup = false
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
-- vim.opt.smarttab = true  -- Uncomment if needed
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.textwidth = 0
vim.opt.wrap = true
vim.opt.wrapmargin = 0
vim.opt.wildignore:append { '*\\tmp\\*', '*.dll', '*.exe', '*.exp', '*.gz', '*.ilk', '*.lib', '*.o', '*.pdb', '*.pch', '*.so', '*.swp', 'tags', '*.tar', '*.zip' }

-- My keymaps and variables
vim.keymap.set('n', '<C-n>', ':tnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', ':tprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F5>', ':cprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F6>', ':cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<2-LeftMouse>', '*', { noremap = true, silent = true })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true, frequency = 43200 },
})
