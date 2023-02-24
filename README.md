# for fresh install

1. [Download Packer](https://github.com/wbthomason/packer.nvim#quickstart)
   \
   `git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"`
2. Open
   [`lua/devpandaz/packer.lua`](https://github.com/devpandaz/nvim/blob/main/lua/devpandaz/packer.lua)
   with neovim (just ignore all the errors at first) and `:so` (source) it.
3. `:PackerSync`
4. Restart neovim.

# to install/remove plugin

1. Go to
   [`lua/devpandaz/packer.lua`](https://github.com/devpandaz/nvim/blob/main/lua/devpandaz/packer.lua)
   and make the changes you want.
2. `:w` (save) and `:so` (source) it.
3. `:PackerInstall` or `:PackerSync`.
4. Enjoy the new plugins. If it does not work as intended, just restart neovim.

# to update any existing plugins setup file

1. Go to the plugin setup file that you want to edit, e.g.
   [`after/plugin/telescope.lua`](https://github.com/devpandaz/nvim/blob/main/after/plugin/telescope.lua).
2. Make your changes.
3. `:w` (save) and `:so` (source) it.
4. Enjoy the changes. If it does not work as intended, just restart neovim.

# to use packer (e.g. to load opt plugins)

1. `:Packer` (it's a custom command, it will `require('devpandaz.packer')`)
2. You can now use any packer command, e.g. (`:PackerLoad` to load optional
   plugins).
