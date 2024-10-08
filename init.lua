----------------------------------------------------------------------------------
--                      Using the lazy.nvim plugin manager
----------------------------------------------------------------------------------
-- Emulate Windows behaviour also for cut/copy/paste
vim.cmd('source $VIMRUNTIME/mswin.vim')

----------------------------------------------------------------------------------
--                                    Plug-ins
----------------------------------------------------------------------------------
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

-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
vim.g.Tlist_Inc_Winwidth = 0
vim.g.Tlist_WinWidth = 70

-- Setup lazy.nvim
require('lazy').setup({
  spec = {
    -- add your plugins here

    -- Add lazy.nvim itself
    {'folke/lazy.nvim', lazy = false},

    -- Old VimScript based plugins
    {'ramojus/mellifluous.nvim', lazy = false},
    {'scrooloose/nerdcommenter', lazy = false},
    {'yegappan/taglist', lazy = false},
    {'drmingdrmer/vim-toggle-quickfix', lazy = false},
    {'tpope/vim-fugitive', lazy = false},

    -- New Neovim Lua based plugins
    {'nvim-tree/nvim-tree.lua', lazy = false},
    {'nvim-lua/plenary.nvim', lazy = false},
    {'nvim-telescope/telescope.nvim', lazy = false},
    {'nvim-treesitter/nvim-treesitter', lazy = false},
    {'nvim-tree/nvim-web-devicons', lazy = false},

    {'VonHeikemen/lsp-zero.nvim',
      dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',

        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
      }
    },

    -- For Github Copilot
    {'zbirenbaum/copilot.lua',
      dependencies = {
        'zbirenbaum/copilot-cmp',
      }
    },

    {'CopilotC-Nvim/CopilotChat.nvim',
      branch = 'canary',
      dependencies = {
        {'zbirenbaum/copilot.lua'}, -- or github/copilot.vim
        {'nvim-lua/plenary.nvim'}, -- for curl, log wrapper
      },
      --build = "make tiktoken", -- Only on MacOS or Linux
      --opts = {
        --debug = true, -- Enable debugging
        -- See Configuration section for rest
      --},
      -- See Commands section for default commands if you want to lazy load on them
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  --install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

----------------------------------------------------------------------------------
--                                General Options
----------------------------------------------------------------------------------
-- My font (on Windows only)
if vim.fn.has('gui_running') == 1 and (vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1) then
  -- The default Windows font.
  -- Install your favourite font and edit the following line (my favourite is: 'Fira Code').
  vim.opt.guifont = 'Cascadia Code:h11'
  --vim.opt.guifont = 'Fira Code:h11.5'
end

if vim.fn.has('win32') or vim.fn.has('win64') then
    vim.opt.rtp:append(vim.fn.expand('~/nvim'))
    --vim.opt.rtp:append(vim.fn.expand('~/nvim/after'))
else
    vim.opt.rtp:append(vim.fn.expand('~/.config/nvim'))
    --vim.opt.rtp:append(vim.fn.expand('~/.config/nvim/after'))
end

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
vim.keymap.set('n', '<F9>', ':TlistToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F10>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F11>', ':term<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<2-LeftMouse>', '*', { noremap = true, silent = true })

-- For plugin 'drmingdrmer/vim-toggle-quickfix':
vim.keymap.set('n', '<C-g><C-o>', '<Plug>window:quickfix:loop', { noremap = false, silent = true })

-- For plugin 'nvim-telescope/telescope.nvim':
-- Note: We have retained the default leader key of: '\' in this configuration.
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

----------------------------------------------------------------------------------
--                         Colorscheme
----------------------------------------------------------------------------------
require('mellifluous').setup({
    dim_inactive = false,
    colorset = 'alduin',
    styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
        main_keywords = {},
        other_keywords = {},
        types = {},
        operators = {},
        strings = {},
        functions = {},
        constants = {},
        comments = { italic = true },
        markup = {
            headings = { bold = true },
        },
        folds = {},
    },
    transparent_background = {
        enabled = false,
        floating_windows = true,
        telescope = true,
        file_tree = true,
        cursor_line = true,
        status_line = false,
    },
    flat_background = {
        line_numbers = false,
        floating_windows = false,
        file_tree = false,
        cursor_line_number = false,
    },
    plugins = {
        cmp = true,
        nvim_tree = {
            enabled = true,
            show_root = false,
        },
        lazy = {
            enabled = true,
        },
        mason = {
            enabled = true,
        },
        telescope = {
            enabled = true,
            nvchad_like = true,
        },
        treesitter = {
            enabled = true,
        }
    },
})

-- My Colour scheme
vim.cmd('colorscheme mellifluous')

----------------------------------------------------------------------------------
--                         Github Copilot
----------------------------------------------------------------------------------
require('copilot').setup({
  panel = {enabled = false},
  suggestion = {enabled = false},
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
})

----------------------------------------------------------------------------------
--                                   LSP
--                     https://lsp-zero.netlify.app/v4.x/tutorial.html
----------------------------------------------------------------------------------
local lsp_zero = require('lsp-zero')

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  vim.keymap.set('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', '<leader>go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set('n', '<F3>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F4>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

----------------------------------------------------------------------------------
--                                   CMP
--                     https://lsp-zero.netlify.app/v4.x/tutorial.html
----------------------------------------------------------------------------------
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'copilot'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Navigate between completion items
    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),

    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.vim_snippet_jump_forward(),
    ['<C-b>'] = cmp_action.vim_snippet_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    -- Github Copilot <TAB> completion
    ['<Tab>'] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})

----------------------------------------------------------------------------------
--                                 NVimTree
----------------------------------------------------------------------------------
require('nvim-tree').setup({
  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 60,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  git = {
    enable = false
  }
})

----------------------------------------------------------------------------------
--                                 Treesitter
----------------------------------------------------------------------------------
require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {'c', 'cpp', 'diff', 'gitcommit', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline'},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  --ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
--  disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
--  disable = function(lang, buf)
--      local max_filesize = 100 * 1024 -- 100 KB
--      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--      if ok and stats and stats.size > max_filesize then
--          return true
--      end
--  end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

----------------------------------------------------------------------------------
--                         Miscellaneous Settings
----------------------------------------------------------------------------------
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

vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

----------------------------------------------------------------------------------
--                         Github Copilot
----------------------------------------------------------------------------------
require('copilot_cmp').setup()
require('CopilotChat').setup()
