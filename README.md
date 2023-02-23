# for fresh install

1. [Download Packer](https://github.com/wbthomason/packer.nvim#quickstart)
   \
   `git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"`
2. Open
   [`lua/devpandaz/packer.lua`](https://github.com/devpandaz/nvim/blob/main/lua/devpandaz/packer.lua)
   with neovim (just ignore all the errors at first) and `:so` (source) it.
3. `:PackerSync`
4. Restart neovim.

# to use packer

1. `:Packer` (it's a custom command, it will `require "devpandaz.packer"`)
2. now can use any packer commands as you like (e.g. `:PackerSync`,
   `:PackerInstall`)
