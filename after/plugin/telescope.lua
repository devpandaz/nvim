-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

local status, telescope = pcall(require, "telescope")
if not status then
  return
end

local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    preview = false,
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
    wrap_results = true,
    layout_strategy = "horizontal",
    sorting_strategy = "ascending",
    winblend = 0,
  },
  pickers = {
    find_files = {
      -- theme = "ivy",
      hidden = true,
      find_command = {
        "rg",
        "--files",
        "--color=never",
        "--no-heading",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob",
        "!{.git/*,.svelte-kit/*,target/*,node_modules/*}",
        "--path-separator",
        "/",
      },
    },
  },
  extensions = {
    file_browser = {
      initial_mode = "normal",
      -- theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {},
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, "fzf")

-- telescope file browser
telescope.load_extension("file_browser")

-- telescope menufacture
telescope.load_extension("menufacture")

-- See `:help telescope.builtin`
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
-- vim.keymap.set("n", "<leader>fb", function()
-- 	local function telescope_buffer_dir()
-- 		return vim.fn.expand("%:p:h")
-- 	end
--
-- 	telescope.extensions.file_browser.file_browser({
-- 		path = "%:p:h",
-- 		-- cwd = telescope_buffer_dir(),
-- 		respect_gitignore = false,
-- 		hidden = true,
-- 		grouped = true,
-- 		previewer = false,
-- 	})
-- end, { desc = "[O]pen file browser" })

-- oil.nvim
vim.keymap.set("n", "<leader>fb", "<cmd>Oil --float<cr>", { desc = "Open [F]ile [B]rowser" })
