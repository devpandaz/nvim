local status, oil = pcall(require, "oil")
if not status then
  return
end

oil.setup({
  delete_to_trash = true,
})
