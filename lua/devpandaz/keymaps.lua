local keymap = vim.keymap

-- See `:help vim.keymap.set()`
keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
keymap.set("n", "k", "v:count == 10 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "j", "v:count == 10 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set("x", "j", "j")
keymap.set("x", "k", "k")

-- to open terminal (powershell) from vim
-- vim.keymap.set('n', '<leader>ot', '<cmd>tabnew<cr><cmd>term pwsh<cr>i', { desc = '[O]pen [T]erminal (powershell)' })
-- to change to normal mode when in terminal mode to enable vim motions
-- vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { desc = 'Escape to normal mode from terminal mode' })

-- copy and paste with system clipboard
keymap.set("v", "<c-c>", '"+y`><esc>', { desc = "Copy to clipboard" }) -- `> is to jump to end of selection (after copying)
keymap.set("v", "<c-x>", '"+x<esc>', { desc = "Cut" })
keymap.set("v", "<c-v>", 'c<esc>"+p', { desc = "Paste from system clipboard" })
keymap.set("i", "<c-v>", '<esc>"+pa', { desc = "Paste from system clipboard" })

-- vim.keymap.set('n', '<s-g>', '<s-g>')
-- vim.keymap.set('n', 'n', 'n')
-- vim.keymap.set('n', 'N', 'N')

-- remap s to nothing. see :h s
keymap.set("n", "s", "")
-- remap gt to sd, <tab> and gT to ds, <s-tab>
keymap.set("n", "sd", "gt", { desc = "go to next tab" })
keymap.set("n", "ds", "gT", { desc = "go to previous tab" })

-- tab to indent in visual mode
keymap.set("x", "<tab>", ">gv", { desc = "indent in" })
keymap.set("x", "<s-tab>", "<gv", { desc = "indent out" })

-- takuya's (craftzdog) remap
-- Increment/decrement
keymap.set("n", "+", "<C-a>", { desc = "increment" })
keymap.set("n", "-", "<C-x>", { desc = "decrement" })

-- new tabedit
keymap.set("n", "<space>te", ":tabedit ")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "select/highlight all" })

-- Split window and open telescope
keymap.set(
  "n",
  "sf",
  '<cmd>vsplit<cr><C-w>w<cmd>lua require("telescope").extensions.menufacture.find_files()<cr>',
  { desc = "open file in vertical split window" }
)
keymap.set(
  "n",
  "sv",
  '<cmd>vsplit<cr><C-w>w<cmd>lua require("telescope.builtin").oldfiles()<cr>',
  { desc = "open recent file in vertical split window" }
)

-- Navigating between windows
keymap.set("n", "<leader>w", "<C-w>w", { desc = "focus next window" })
keymap.set("", "sn", "<C-w>h", { desc = "focus the window at the left" })
keymap.set("", "sk", "<C-w>k", { desc = "focus the window above" })
keymap.set("", "sj", "<C-w>j", { desc = "focus the window below" })
keymap.set("", "sm", "<C-w>l", { desc = "focus the window at the right" })

-- Resize window
keymap.set("n", "s<right>", "<C-w><", { desc = "move window border to the right" })
keymap.set("n", "s<left>", "<C-w>>", { desc = "move window border to the left" })
keymap.set("n", "s<up>", "<C-w>+", { desc = "move window border upwards" })
keymap.set("n", "s<down>", "<C-w>-", { desc = "move window border downwards" })

-- delete entire word with ctrl + backspace (see link below as to why ctrl-h is mapped instead of <c-bs>)
-- https://www.reddit.com/r/neovim/comments/okbag3/comment/h58k9p7/?utm_source=share&utm_medium=web2x&context=3
keymap.set("i", "<c-h>", "<c-w>", { desc = "delete entire word with ctrl + backspace" })

-- to prevent the stupid error when pressing shift k in visual mode
keymap.set("v", "<s-k>", "")

keymap.set("n", "H", "^")
keymap.set("n", "L", "$")
keymap.set("n", "J", "}")
-- vim.keymap.set("n", "K", "{") -- reserved for lspsaga for inline auto documentation

-- close tabs to the right
keymap.set("n", "<leader>cr", "<cmd>.+1,$tabdo :tabc<cr>")

-- replacing neoformat to use lsp to format
keymap.set("n", "<leader>for", "<cmd>Format<cr>", { desc = "Format this file" })
keymap.set("n", "<leader>fon", "<cmd>Neoformat<cr>", { desc = "Format this file (neoformat)" })

-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
keymap.set("n", "gh", "<cmd>Lspsaga finder<CR>")

-- Code action
keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the selected files
keymap.set("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
-- keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<cr>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
keymap.set("n", "<C-k>", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap.set("n", "<C-j>", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Toggle outline
keymap.set("n", "<leader>ol", "<cmd>Lspsaga outline<CR>")

-- Pressing the key twice will enter the hover window
keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- telescope
-- See `:help telescope.builtin`
local status, telescope = pcall(require, "telescope")
if not status then
  return
end
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>?", function()
  builtin.oldfiles()
end, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", function()
  builtin.buffers()
end, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
  }))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", function()
  telescope.extensions.menufacture.find_files()
end, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", telescope.extensions.menufacture.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", telescope.extensions.menufacture.live_grep, { desc = "[S]earch by [G]rep" })
-- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- more keymaps lmao
-- open file in new tab
vim.keymap.set("n", "<leader>of", function()
  vim.cmd("tabnew")
  telescope.extensions.menufacture.find_files()
end, { desc = "[O]pen [F]ile in new tab" })

-- open recent file in new tab
vim.keymap.set("n", "<leader>or", function()
  vim.cmd("tabnew")
  builtin.oldfiles()
end, { desc = "[O]pen [R]ecent file in new tab" })

-- open existing buffers in new tab
vim.keymap.set("n", "<leader>ob", function()
  vim.cmd("tabnew")
  builtin.buffers()
end, { desc = "[O]pen [B}uffer in new tab" })

-- open telescope file browser
-- vim.keymap.set('n', '<leader>fb', function() telescope.extensions.file_browser.file_browser({ git_status = true, path="%:p:h", select_buffer = true}) end)

-- oil.nvim
vim.keymap.set("n", "<leader>fb", "<cmd>Oil --float<cr>", { desc = "Open [F]ile [B]rowser" })
