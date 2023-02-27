local status, autotag = pcall(require, 'nvim-ts-autotag')
if (not status) then return end

-- autoclose and autorename html tags
autotag.setup()

