-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('x', 'j', 'j')
vim.keymap.set('x', 'k', 'k')

----- custom keymaps ------

-- to open terminal (powershell) from vim
-- vim.keymap.set('n', '<leader>ot', '<cmd>tabnew<cr><cmd>term pwsh<cr>i', { desc = '[O]pen [T]erminal (powershell)' })
-- to change to normal mode when in terminal mode to enable vim motions
-- vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { desc = 'Escape to normal mode from terminal mode' })

-- navigating between windows
-- vim.keymap.set('n', '<leader>tj', '<c-w>j', { desc = '[T]o [j] Window Below' })
-- vim.keymap.set('n', '<leader>tk', '<c-w>k', { desc = '[T]o [j] Window Above' })
-- vim.keymap.set('n', '<leader>th', '<c-w>h', { desc = '[T]o [j] Window Left' })
-- vim.keymap.set('n', '<leader>tl', '<c-w>l', { desc = '[T]o [j] Window Right' })

-- copy and paste with system clipboard
vim.keymap.set('v', '<c-c>', '"+y<esc>', { desc = 'Copy to clipboard' })
vim.keymap.set('v', '<c-x>', '"+c<esc>', { desc = 'Cut' })
vim.keymap.set('v', '<c-v>', 'c<esc>"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('i', '<c-v>', '<esc>"+pa', { desc = 'Paste from system clipboard' })

vim.keymap.set('n', '<s-g>', '<s-g>')
vim.keymap.set('n', 'n', 'n')
vim.keymap.set('n', 'N', 'N')

-- remap s to nothing. see :h s
vim.keymap.set('n', 's', '')
-- remap gt to sd and gT to ds
vim.keymap.set('n', 'sd', 'gt', { desc = 'go to next tab' })
vim.keymap.set('n', 'ds', 'gT', { desc = 'go to previous tab' })

-- tab to indent in visual mode
vim.keymap.set('x', '<tab>', '>gv', { desc = 'indent in' })
vim.keymap.set('x', '<s-tab>', '<gv', { desc = 'indent out' })

-- takuya's (craftzdog) remap
-- Increment/decrement
vim.keymap.set('n', '+', '<C-a>', { desc = 'increment' })
vim.keymap.set('n', '-', '<C-x>', { desc = 'decrement' })

-- new tab
vim.keymap.set('n', 'te', ':tabedit')

-- Select all
vim.keymap.set('n', '<C-a>', 'gg<S-v>G', { desc = 'select/highlight all' })

-- Split window and open telescope
vim.keymap.set('n', 'sf', '<cmd>vsplit<cr><C-w>w<cmd>lua require("telescope").extensions.menufacture.find_files()<cr>', { desc = 'open file in vertical split window' })
vim.keymap.set('n', 'sv', function() vim.cmd[[vsplit<cr><C-w>w]] builtin.old_files() end, { desc = 'split window horizontal' })
vim.keymap.set('n', 'sv', '<cmd>vsplit<cr><C-w>w<cmd>lua require("telescope.builtin").oldfiles()<cr>', { desc = 'open recent file in vertical split window' })

-- Navigating between windows
vim.keymap.set('n', '<leader>w', '<C-w>w', { desc = 'focus next window' })
vim.keymap.set('', 'sh', '<C-w>h', { desc = 'focus the window at the left' })
vim.keymap.set('', 'sk', '<C-w>k', { desc = 'focus the window above' })
vim.keymap.set('', 'sj', '<C-w>j', { desc = 'focus the window below' })
vim.keymap.set('', 'sl', '<C-w>l', { desc = 'focus the window at the right' })

-- Resize window
vim.keymap.set('n', 's<right>', '<C-w><', { desc = 'move window border to the right' })
vim.keymap.set('n', 's<left>', '<C-w>>', { desc = 'move window border to the left' })
vim.keymap.set('n', 's<up>', '<C-w>+', { desc = 'move window border upwards' })
vim.keymap.set('n', 's<down>', '<C-w>-', { desc = 'move window border downwards' })
