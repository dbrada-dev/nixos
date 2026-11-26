-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "radium",

  hl_override = {
    Comment = {italic = true},
    ["@comment"] = {italic = true},
  },
}

M.ui = {
  telescope = {style = "bordered"},
  statusline = {
    order = {"mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "cwd", "cursor"},
  },
}

M.nvdash = {
  load_on_startup = true,
  buttons = {
    {txt = "  Empty buffer", keys = "<leader>b", cmd = "Nvdash"},
    {txt = "  Find File", keys = "ff", cmd = "Telescope find_files"},
    {txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles"},
    {txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep"},
    {txt = "  Neogit", keys = "<leader>gl", cmd = "Neogit"},
    {txt = "─", hl = "NvDashFooter", no_gap = true, rep = true},
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },
    {txt = "─", hl = "NvDashFooter", no_gap = true, rep = true},
  },
}

M.term = {
  float = {
    row = 0.2,
    col = 0.15,
    width = 0.7,
    height = 0.6,
    border = "rounded",
  },
}

return M
