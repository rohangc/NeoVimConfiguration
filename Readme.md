# Usage Guide:

## Installation:

1. Install the latest version of Neovim and optionally, a GUI like 'Neovide'.

2. Install the following software and ensure that they binaries are accessible via your 'PATH' environment variable along with Neovim itself:
   * Git (should also automatically install Curl. If not, install Curl manually).
   * For the Treesitter syntax highlighting plugin to work, you need to install and add LLVM (Clang) C/C++ compiler to your PATH. (All this is done automatically, but refer this link for more information: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#llvm-clang).
   * Node.js (for the Github Copilot plugin).
   * Many plugins need Python to work. Install a 64-bit Python distribution, make it available through the PATH environment variable, and install the Python Neovim package by using command: "pip install neovim".
   * Optional step - configure Neovim to use your favourite font:
     * Install your favourite font and modify the line containing: 'vim.opt.guifont' in: 'init.lua' to load this font in Neovim.
     * In our configuration file:
       * On Linux: the default terminal font is used.
       * On Windows, the font used in this configuration is: "Cascadia Code" (https://github.com/microsoft/cascadia-code/wiki/Installing-Cascadia-Code) which is installed automatically along with "Windows Terminal".

3. Clone/copy the files of this repo into any directory of your choice.

4. Invoke a Bash shell with access to Git. On Windows, this is also called as: "Git Bash":
   * Navigate to the directory where the cloned files are located.
   * Execute the script: 'NvimConfigure.sh'.
   * Troubleshooting on Linux - if bash complains that the file was not found:
     * Change the file encoding of the shell script from DOS to Unix. One way to do that is to open the script in Neovim, enter command: ":set ff=unix" and save the file.
     * Set execute permissions on the shell script. In the bash shell, execute command: "chmod 555 ./*.sh".

5. Invoke Neovim - it should automatically start installing plugins using the 'Lazy' plugin manager.
   * In the Lazy.nvim plugin manager GUI, key in: "Shift + U" multiple times to update all installed plugins.
   * Key-in: "Shift + I" to install any plugins that were not installed.
   * Exit 'Lazy' by typing: ':q'. You can invoke 'Lazy' any time you want by entering command: ':Lazy'.
   * Enter command: ':MasonUpdate' to update the Mason registry (a package manager for LSP, linters, etc.).
   * Open any source code file in Neovim.
   * Execute command: ":LspInstall" - this magically installs the Language Server required for the type of file currently open! You can also manually install the LSP servers for any programming language by navigation within the Mason window (invoked by entering command: ':Mason') and by typing: 'i' (type: 'g?' within the Mason window for more help).

6. In Neovim, setup Copilot by entering command: ':Copilot setup' and follow on-screen instructions.
   * If for some reason, Copilot was not authenticated during setup, you can re-authenticate Copilot by entering command: ':Copilot auth' and following on-screen instructions.

7. Execute command ':checkhealth'.
   * This shows you a list of missing/broken/incompatible dependencies (other programs) that need to be resolved for Neovim to work.
   * Resolve those issues.
   * Restart Neovim.

## Extras and Useful Links:
### Clang/Clangd:

1. Clangd C++ Language Server: install and configure Cmake to generate a compilation database ('compile_commands.json') of your C++ project (see: https://github.com/ycm-core/YouCompleteMe#c-family-semantic-completion). The Clangd Language Server for C++ won't work if 'compile_commands.json' isn't found in your project directory.
2. If you are unable to use Cmake for generating 'compile_commands.json', you may need to install and configure your build system to use a utility such as 'compiledb' or 'Bear' to create the compilation database.
3. Optional step: copy '.clang-tidy' (after modifying it as necessary) into the 'root' directory that holds all your projects.
4. Optional step: copy 'clangd/config.yaml' (after modifying it as necessary) into a directory mentioned here: https://clangd.llvm.org/config.html#files.
5. Clangd documentation: https://clangd.llvm.org/installation
6. Force CMake to build your project using all available cores on your system: https://blog.kitware.com/cmake-building-with-all-your-cores
7. Use Clang (instead of MSVC) to build projects in Visual Studio: https://docs.microsoft.com/en-us/cpp/build/clang-support-msbuild
