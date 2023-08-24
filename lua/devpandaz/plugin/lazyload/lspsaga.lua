require('lspsaga').setup {
  ui = {
    winblend = 10,
    border = 'rounded',
    colors = {
      normal_bg = '#002b36'
    },
    kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
  }
}

local keymap = vim.keymap.set

-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the selected files
keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
-- keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<cr>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
keymap("n", "<C-k>", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "<C-j>", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Toggle outline
keymap("n","<leader>ol", "<cmd>Lspsaga outline<CR>")

-- Pressing the key twice will enter the hover window
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
