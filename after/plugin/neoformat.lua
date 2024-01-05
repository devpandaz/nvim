local status = vim.fn.exists(':Neoformat') > 0
if (not status) then return end

-- neoformat setup (kinda like prettier)
-- format on save
-- vim.cmd [[
-- augroup fmt
--   autocmd!
--   au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
-- augroup END
-- ]]

vim.keymap.set("n", "<leader>for", "<cmd>Neoformat<cr>", { desc = "Format this file" })
