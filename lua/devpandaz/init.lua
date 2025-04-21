require("devpandaz.set")
require("devpandaz.remap")
pcall(require("impatient"))
require("devpandaz.packer")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.api.nvim_create_user_command("DiscordPresence", function()
	vim.cmd([[PackerLoad presence.nvim]])
end, {})

-- replacing neoformat to use lsp to format
vim.keymap.set("n", "<leader>for", "<cmd>Format<cr>", { desc = "Format this file" })
vim.keymap.set("n", "<leader>fon", "<cmd>Neoformat<cr>", { desc = "Format this file (neoformat)" })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
