# Overview:
A simple, efficient and effective [Neovim](https://neovim.io) customization meant primarily for development of large C++ projects using:
1. [Clangd](https://clangd.llvm.org) as the [LSP](https://microsoft.github.io/language-server-protocol/) (Language Server Protocol) server.
1. [Git](https://git-scm.com) as the [VCS](https://en.wikipedia.org/wiki/Version_control) (Version Control System).
1. [Github Copilot](https://github.com/features/copilot) for Generative AI bells and whistles.

# Usage Guide:
## Installation:

1. Install the latest version of [Neovim](https://neovim.io) and a GUI like [Neovide](https://neovide.dev).
   1. Ensure that Neovim is added to your 'PATH' environment variable.

1. Install the following software and ensure that their binaries are accessible via your 'PATH' environment variable:
   1. [Git](https://git-scm.com/downloads) and [Curl](https://curl.se/download.html) (on Windows, installing the official Git distribution also installs Curl).
   1. [Python (64-bit)](https://www.python.org/downloads).
      1. Install Python's 'Neovim' package:
         ```bash
         pip install neovim.
         ```
   1. For the Treesitter plugin:
      1. If a C/C++ compiler is not available in 'PATH' environment variable, install the [Clang C/C++ compiler](https://releases.llvm.org/download.html). Read [this](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#llvm-clang) for details.
         * On Windows:
           * For some reason, the Treesiter plugin cannot find standard C/C++ header files with the LLVM Clang installation ([read this](https://clangd.llvm.org/troubleshooting#cant-find-standard-library-headers-map-stdioh-etc)).
           * Hence, install [Microsoft Visual Studio](https://visualstudio.microsoft.com) (even the free "Community Edition" will suffice).
           * There is no need to add 'cl.exe' to 'PATH' environment variable. Treesitter somehow seems to find the header files it needs from the VS installation directory.
   1. For the 'Telescope' plugin:
        1. [RipGrep](https://github.com/BurntSushi/ripgrep).
           * On Windows, enter command:
             ```bash
             winget install BurntSushi.ripgrep.MSVC
             ```
        1. [Fd](https://github.com/sharkdp/fd).
           * On Windows, enter command:
             ```bash
             winget install sharkdp.fd
             ```
   1. [Node.js](https://nodejs.org/en/download) for Github Copilot.

1. Install a [Nerd Font](https://www.nerdfonts.com) and configure Neovim to use it:
   1. Specify the font by modifying the line containing: 'vim.opt.guifont' in: 'lua/config/options.lua'.
   1. The default font in our configuration file:
      1. Linux: the default terminal font is used (might not be a "Nerd Font"!).
      1. Windows: [Cascadia Code](https://github.com/microsoft/cascadia-code/wiki/Installing-Cascadia-Code) which is installed automatically along with [Microsoft Terminal](https://github.com/microsoft/terminal).
         * The version bundled with Windows terminal is not a "Nerd Font" as it lacks many glyphs, but it is just enough to get the job done.
         * There is "Nerd Font" version of "Cascadia Code", but it needs to be installed separately and I haven't tested it.
         * I highly recommend you to install a different "Nerd Font". My favourite is: [JuliaMono Nerd Font](https://github.com/mietzen/juliamono-nerd-font).

1. Clone/copy the files of this repo into any directory of your choice.

1. Invoke a Bash shell with access to Git (on Windows, this is called: "Git Bash"):
   1. Navigate to the directory where the cloned files are located.
   1. Execute the script:
      ```bash
      NvimConfigure.sh
      ```
   1. Troubleshooting on Linux - if Bash complains that the script file was not found even though the file exists in the directory:
      * Change the file encoding of the shell script from DOS to Unix using command:
      ```bash
      dos2unix NvimConfigure.sh
      ```
      * Set execute permissions on the shell script by executing command:
      ```bash
      chmod +x NvimConfigure.sh
      ```
1. Invoke Neovim - it should automatically start installing plugins using the 'lazy.nvim' plugin manager.
   1. In the 'lazy.nvim' plugin manager GUI, key in: ```Shift + U``` multiple times to update all installed plugins.
   1. Exit 'lazy.nvim' by entering: ```:q```. You can re-invoke 'lazy.nvim' any time you want by entering command: ```:Lazy```.
   1. Enter command: ```:MasonUpdate``` to update the Mason registry (a package manager for LSP, linters, etc.).
   1. The Clangd Language server for C/C++ is installed by default. To install LSP servers of other pragramming languages.
      1. Open any source file (with the appropriate file extension) in Neovim.
      1. Execute command: ```:LspInstall``` - this installs the Language Server required for the type of file currently open.
         * You can also manually install LSP servers for any other programming language by navigation within the Mason window (invoked by entering command: ```:Mason```) and by typing: ```i``` (type: ```g?``` within the Mason window for more help).
   1. Authenticate Github Copilot by entering command: ```:Copilot auth``` and following on-screen instructions.

1. Execute command ```:checkhealth```
   1. This shows you a list of missing/broken/incompatible dependencies (other programs) that need to be resolved for Neovim to work.
   1. Resolve those issues.
   1. Restart Neovim.

## Notes:

1. We have retained the default 'leader' key: '\\'. If you want to change it to the more popular: SPACE, you can do so in file: 'lua/config/options.lua'.
1. In this Neovim configuration, we don't install any plugins for DAPs, linters and formatters. 'Mason' is used to install and manage LSP servers only.
