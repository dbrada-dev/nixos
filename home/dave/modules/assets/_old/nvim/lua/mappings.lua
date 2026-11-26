require "nvchad.mappings"

vim.keymap.set('n', '<leader>s', function()
    vim.opt.spell = not vim.opt.spell:get()
    print("Spell check: " .. tostring(vim.opt.spell:get()))
end, {desc = "Toggle spell check"})

vim.keymap.set('n', '<leader>rn', function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
    vim.opt.number = not vim.opt.number:get()
end, {desc = "Toggle relative line numbers"})

local km = vim.keymap.set
km("n", "<localleader>ll", vim.cmd.VimtexCompile, { desc = "VimtexCompile" })
km("n", "<localleader>lv", vim.cmd.VimtexView, { desc = "VimtexView" })
km("n", "<localleader>lc", vim.cmd.VimtexCompileSS, { desc = "VimtexCompileSS" })
km("n", "<localleader>le", vim.cmd.VimtexErrors, { desc = "VimtexErrors" })
km("n", "<localleader>lo", vim.cmd.VimtexOutput, { desc = "VimtexOutput" })
km("n", "<localleader>ls", vim.cmd.VimtexStop, { desc = "VimtexStop" })
km("n", "<localleader>lS", vim.cmd.VimtexStopAll, { desc = "VimtexStopAll" })
km("n", "<localleader>li", vim.cmd.VimtexInfo, { desc = "VimtexInfo" })
km("n", "<localleader>lT", vim.cmd.VimtexTocOpen, { desc = "VimtexTocOpen" })


local map = vim.keymap.set
map("n", ";", ":", {desc = "CMD enter command mode"})
map("i", "jk", "<ESC>")
map("n", "<leader>ca", vim.lsp.buf.code_action, {desc = "LSP code action"})
