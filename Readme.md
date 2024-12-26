# Usage Guide:

## Installation:

1. Install the latest version of Neovim and a GUI like 'Neovide'.
   * Ensure that Neovim is added to your 'PATH'.

2. Install the following software and ensure that they binaries are accessible via your 'PATH':
   * Git and Curl (on Windows, installing the official Git distribution also installs Curl).
   * If a C/C++ compiler is not available in 'PATH', install the Clang C/C++ compiler for the Treesitter syntax highlighting plugin (https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#llvm-clang).
   * Python (64-bit) and its 'Neovim' package (enter this command in the shell prompt: "pip install neovim").
   * For the 'Telescope' plugin:
     * RipGrep (https://github.com/BurntSushi/ripgrep).
       * On Windows, enter command:
         ```bash
         winget install BurntSushi.ripgrep.MSVC
         ```
     * Fd (https://github.com/sharkdp/fd).
       * On Windows, enter command:
         ```bash
         winget install sharkdp.fd
         ```
   * On Windows:
     * For some reason, the Treesiter plugin cannot find standard C/C++ header files with the LLVM Clang installation (https://clangd.llvm.org/troubleshooting#cant-find-standard-library-headers-map-stdioh-etc).
     * Hence, install Visual Studio (even the free "Community Edition" will suffice).
     * There is no need to add 'cl.exe' to 'PATH'. Treesitter somehow seems to find the header files it needs from the VS installation directory.
   * Node.js for Github Copilot.

3. Install a "Nerd Font" from: https://www.nerdfonts.com and configure Neovim to use it:
   * Specify the font by modifying the line containing: 'vim.opt.guifont' in: 'lua/config/options.lua'.
   * The default font in our configuration file:
     * Linux: the default terminal font is used (might not be a "Nerd Font"!).
     * Windows: "Cascadia Code" (https://github.com/microsoft/cascadia-code/wiki/Installing-Cascadia-Code) which is installed automatically along with "Windows Terminal".
       * The version bundled with Windows terminal is not a "Nerd Font" as it lacks many glyphs, but it is just enough to get the job done.
       * There is "Nerd Font" version of "Cascadia Code", but it needs to be installed separately and I haven't tested it.
       * I highly recommend you to install a different "Nerd Font". My favourite is: "JuliaMono Nerd Font" (https://github.com/mietzen/juliamono-nerd-font).

4. Clone/copy the files of this repo into any directory of your choice.

5. Invoke a Bash shell with access to Git (on Windows, this is called: "Git Bash"):
   * Navigate to the directory where the cloned files are located.
   * Execute the script: 'NvimConfigure.sh'.
   * Troubleshooting on Linux - if Bash complains that the script file was not found even though the file exists in the directory:
     * Change the file encoding of the shell script from DOS to Unix using command: "dos2unix NvimConfigure.sh".
     * Set execute permissions on the shell script by executing command: "chmod 555 NvimConfigure.sh".

6. Invoke Neovim - it should automatically start installing plugins using the 'lazy.nvim' plugin manager.
   * In the 'lazy.nvim' plugin manager GUI, key in: "Shift + U" multiple times to update all installed plugins.
   * Exit 'lazy.nvim' by entering: ':q'. You can re-invoke 'lazy.nvim' any time you want by entering command: ':Lazy'.
   * Enter command: ':MasonUpdate' to update the Mason registry (a package manager for LSP, linters, etc.).
     * In this Neovim configuration, we don't install any plugins for DAP, linters and formatters. 'Mason' is used to install and manage LSP servers only.
   * The Clangd Language server for C/C++ is installed by default. To install LSP servers of other pragramming languages.
     * Open any source file (with the appropriate file extension) in Neovim.
     * Execute command: ":LspInstall" - this installs the Language Server required for the type of file currently open.
       * You can also manually install LSP servers for any other programming language by navigation within the Mason window (invoked by entering command: ':Mason') and by typing: 'i' (type: 'g?' within the Mason window for more help).
   * To activate Copilot, execute this command: ":Copilot auth" and follow on-screen instructions.

7. Execute command ':checkhealth'.
   * This shows you a list of missing/broken/incompatible dependencies (other programs) that need to be resolved for Neovim to work.
   * Resolve those issues.
   * Restart Neovim.

8. Optional:
   * Copy '.clang-format' and '.clang-tidy' (after modifying them as necessary) into the 'root' directory that holds all your projects.
   * Copy 'clangd/config.yaml' (after modifying it as necessary) into a directory mentioned here: https://clangd.llvm.org/config.html#files.


## Note:

1. We have retained the default 'leader' key: '\\'. If you want to change it to the more popular: SPACE, you can do so in file: 'lua/config/options.lua'.
2. Clangd C++ Language Server: install and configure Cmake to generate a compilation database ('compile_commands.json') of your C++ project (see: https://github.com/ycm-core/YouCompleteMe#c-family-semantic-completion). The Clangd Language Server for C++ won't work if 'compile_commands.json' isn't found in your project directory.
   * If you are unable to use Cmake for generating 'compile_commands.json', you may need to install and configure your build system to use a utility such as 'compiledb' or 'Bear' to create the compilation database.


## Extras and Useful Links:
### Clang/Clangd:

1. Clangd documentation: https://clangd.llvm.org/installation
2. Force Cmake to build your project using all available cores on your system: https://blog.kitware.com/cmake-building-with-all-your-cores
3. Use Clang (instead of MSVC) to build projects in Visual Studio: https://docs.microsoft.com/en-us/cpp/build/clang-support-msbuild

### Git:
1. To configure git to use a third party diff and merge tool for the 'git difftool' command (p4diff and p4merge, for example):
   ```bash
   git config --global diff.tool p4merge
   git config --global difftool.p4merge.cmd 'p4merge.exe $LOCAL $REMOTE'
   git config --global difftool.prompt false

   git config --global merge.tool p4merge
   git config --global mergetool.p4merge.cmd 'p4merge.exe $BASE $LOCAL $REMOTE $MERGED'
   git config --global mergetool.prompt false
   git config --global mergetool.trustExitCode false
   git config --global mergetool.keepBackup false
   ```
