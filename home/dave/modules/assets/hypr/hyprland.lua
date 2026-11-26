-- █▀▀ █▀▀ █▄░█ █▀▀ █▀█ ▄▀█ █░░
-- █▄█ ██▄ █░▀█ ██▄ █▀▄ █▀█ █▄▄
local home = os.getenv("HOME")
package.path = package.path .. ";" .. home .. "/.config/hypr/?.lua;" .. home .. "/.config/hypr/cfg/?.lua"

local handle = io.popen("ls " .. home .. "/.config/hypr/cfg/")
if handle then
  for line in handle:lines() do
    local mod = line:match("(.+)%.lua$")
    if mod then pcall(require, mod) end
  end handle:close()
end
pcall(require, "device_specific")

hl.config({
  input = {
    kb_layout  = "cz",
    kb_variant = "coder",
  },
})
