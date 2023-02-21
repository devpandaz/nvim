-- nvim file tree setup --

-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- require("nvim-tree").setup({
--   git = {
--     ignore = false,
--   },
--   filters = {
--     dotfiles = true,
--   },
--   expand_all = {
--     exclude = {".git", "build", "node_modules"}
--   }
-- })

-- keymap to toggle nvim tree
-- vim.keymap.set('n', '<leader>tr', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle File [Tr]ee' })

