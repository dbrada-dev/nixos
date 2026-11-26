-- █▄▄ █ █▄░█ █▀▄ █▀
-- █▄█ █ █░▀█ █▄▀ ▄█
local function keys(...)
  local key_list = {...}
  local result = key_list[1]
  for i = 2,#key_list do
    result = result .. " + " .. key_list[i]
  end
  return result
end

local mainmod = "SUPER"

-- █▀▄▀█ █ █▀ █▀▀
-- █░▀░█ █ ▄█ █▄▄
hl.bind(keys(mainmod, "M"), hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"), {locked = true})
hl.bind(keys(mainmod, "SHIFT", "L"), function()
  local current_opts = hl.get_config("input.kb_options") or ""
  local new_opts = ""

  if current_opts:match("caps:swapescape") then
    new_opts = current_opts:gsub("caps:swapescape", "")
                           :gsub(",,", ",")
                           :gsub("^,", "")
                           :gsub(",$", "")
    hl.dispatch(hl.dsp.exec_cmd("notify-send 'CapsLock' 'Caps_Lock capslocks' --icon dialog-information"))
  else
    if current_opts == "" then
      new_opts = "caps:swapescape"
    else
      new_opts = current_opts .. ",caps:swapescape"
    end
    hl.dispatch(hl.dsp.exec_cmd("notify-send 'CapsLock' 'Escape capslocks' --icon dialog-information"))
  end
  hl.config({input = {kb_options = new_opts}})
end)


-- ▄▀█ █▀█ █▀█ █▀
-- █▀█ █▀▀ █▀▀ ▄█
hl.bind(keys(mainmod, "F1"), hl.dsp.exec_cmd("hyprlock"))
hl.bind(keys(mainmod, "F2"), hl.dsp.exec_cmd([[pkill swaybg ; swaybg -m find -i "$(find ~/wallpapers -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.webp' \) | shuf -n1)"]]))
hl.bind(keys(mainmod, "SHIFT", "return"), hl.dsp.exec_cmd("foot"))
hl.bind(keys(mainmod, "SHIFT", "T"), hl.dsp.exec_cmd("foot"))
hl.bind(keys(mainmod, "O"), hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(keys(mainmod, "F"), hl.dsp.exec_cmd("foot yazi"))
hl.bind(keys(mainmod, "E"), hl.dsp.exec_cmd("foot yazi"))
hl.bind(keys(mainmod, "B"), hl.dsp.exec_cmd("firefox"))
hl.bind(keys(mainmod, "N"), hl.dsp.exec_cmd("swaync-client -t -sw || (swaync & sleep 0.2 && swaync-client -t -sw)"))

-- █▀ █▀▀ █▀█ █▀▀ █▀▀ █▄░█ █▀ █░█ █▀█ ▀█▀
-- ▄█ █▄▄ █▀▄ ██▄ ██▄ █░▀█ ▄█ █▀█ █▄█ ░█░
-- Copy and save
local screenshotPath = os.getenv("HOME") .. "/Pictures/Screenshots/img_$(date +'%Y-%m-%d_%H-%M-%S').png"
hl.bind(keys(mainmod, "SHIFT", "S"), hl.dsp.exec_cmd("/usr/bin/env sh -c 'grimblast -f copysave area " .. screenshotPath .. "'"))
hl.bind(keys(mainmod, "S"), hl.dsp.exec_cmd("/usr/bin/env sh -c 'grimblast copysave active " .. screenshotPath .. "'"))
hl.bind(keys("print"), hl.dsp.exec_cmd("/usr/bin/env sh -c 'grimblast copysave output " .. screenshotPath .. "'"))
hl.bind(keys(mainmod, "print"), hl.dsp.exec_cmd("/usr/bin/env sh -c 'grimblast copysave screen " .. screenshotPath .. "'"))
-- Copy and swappy
hl.bind(keys(mainmod, "CTRL", "SHIFT", "S"), hl.dsp.exec_cmd("grimblast copysave area '-' | swappy -f -"))

-- █░█░█ █▀█ █▀█ █▄▀ █▀ █▀█ ▄▀█ █▀▀ █▀▀ █▀
-- ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ █▀▀ █▀█ █▄▄ ██▄ ▄█
for i = 1, 10 do
    local key = (i == 10) and "0" or tostring(i)
    local ws = tostring(i)
    hl.workspace_rule({workspace = ws, persistent = true})
    hl.bind(keys(mainmod, key), hl.dsp.focus({workspace = ws}))
    hl.bind(keys(mainmod, "SHIFT", key), hl.dsp.window.move({workspace = ws, follow = false}))
end
hl.bind(keys(mainmod, "right"), hl.dsp.focus({workspace = "r+1"}))
hl.bind(keys(mainmod, "left"), hl.dsp.focus({workspace = "r-1"}))
hl.bind(keys(mainmod, "SHIFT", "right"), hl.dsp.window.move({workspace = "r+1", follow = false}))
hl.bind(keys(mainmod, "SHIFT", "left"), hl.dsp.window.move({workspace = "r-1", follow = false}))

hl.bind(keys(mainmod, "grave"), hl.dsp.workspace.toggle_special("generic"))
hl.bind(keys(mainmod, "SHIFT", "grave"), hl.dsp.window.move({workspace = "special:generic", follow = false}))

hl.bind(keys(mainmod, "CTRL", "grave"), hl.dsp.submap("special_workspaces"))
hl.define_submap("special_workspaces", function()
  hl.bind(keys("escape"), hl.dsp.submap("reset"))
end)

-- █▀▄▀█ █▀█ █░█ █▀ █▀▀
-- █░▀░█ █▄█ █▄█ ▄█ ██▄
hl.bind(keys(mainmod, "mouse:272"), hl.dsp.window.drag(), {mouse = true})
hl.bind(keys(mainmod, "mouse:273"), hl.dsp.window.resize(), {mouse = true})
hl.bind(keys(mainmod, "mouse_up"), hl.dsp.focus({workspace = "e+1"}))
hl.bind(keys(mainmod, "mouse_down"), hl.dsp.focus({workspace = "e-1"}))

-- █▀▀ █▀▀ █▀ ▀█▀ █░█ █▀█ █▀▀ █▀
-- █▄█ ██▄ ▄█ ░█░ █▄█ █▀▄ ██▄ ▄█
hl.gesture({fingers = 3, direction = "horizontal", action = "workspace"})
hl.gesture({fingers = 4, direction = "down", action = "close"})
hl.gesture({fingers = 4, mods = keys(mainmod), direction = "horizontal", action = "resize"})
hl.gesture({fingers = 4, mods = keys(mainmod), direction = "vertical", action = "resize"})
hl.gesture({fingers = 4, mods = keys(mainmod, "SHIFT"), direction = "swipe", action = "move"})

-- █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
-- ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █░▀░█ █▀█ █░▀█ █▀█ █▄█ █░▀░█ ██▄ █░▀█ ░█░
hl.bind(keys("ALT", "F4"), hl.dsp.window.close())
hl.bind(keys(mainmod, "SHIFT", "C"), hl.dsp.window.close())
hl.bind(keys("F11"), hl.dsp.window.fullscreen({action = "toggle"}))
hl.bind(keys(mainmod, "V"), hl.dsp.window.fullscreen({action = "toggle"}))
hl.bind(keys(mainmod, "T"), hl.dsp.window.float({action = "toggle"}))
hl.bind(keys(mainmod, "CTRL", "space"), hl.dsp.layout("togglesplit"))
hl.bind(keys(mainmod, "P"), hl.dsp.window.pseudo())

hl.bind(keys(mainmod, "J"), hl.dsp.focus({direction = "l"}))
hl.bind(keys(mainmod, "K"), hl.dsp.focus({direction = "r"}))
hl.bind(keys(mainmod, "U"), hl.dsp.focus({direction = "u"}))
hl.bind(keys(mainmod, "M"), hl.dsp.focus({direction = "d"}))

hl.bind(keys(mainmod, "SHIFT", "J"), hl.dsp.window.move({direction = "l"}))
hl.bind(keys(mainmod, "SHIFT", "K"), hl.dsp.window.move({direction = "r"}))
hl.bind(keys(mainmod, "SHIFT", "U"), hl.dsp.window.move({direction = "u"}))
hl.bind(keys(mainmod, "SHIFT", "M"), hl.dsp.window.move({direction = "d"}))

hl.bind(keys(mainmod, "CTRL", "J"), hl.dsp.window.resize({x = -30, y = 0, relative = true}), {repeating = true})
hl.bind(keys(mainmod, "CTRL", "K"), hl.dsp.window.resize({x = 30, y = 0, relative = true}), {repeating = true})
hl.bind(keys(mainmod, "CTRL", "U"), hl.dsp.window.resize({x = 0, y = -30, relative = true}), {repeating = true})
hl.bind(keys(mainmod, "CTRL", "M"), hl.dsp.window.resize({x = 0, y = 30, relative = true}), {repeating = true})

-- █▀▄▀█ █▀▀ █▀▄ █ ▄▀█
-- █░▀░█ ██▄ █▄▀ █ █▀█
hl.bind(keys("XF86AudioRaiseVolume"), hl.dsp.exec_cmd("swayosd-client --output-volume raise"), {repeating = true, locked = true})
hl.bind(keys("XF86AudioLowerVolume"), hl.dsp.exec_cmd("swayosd-client --output-volume lower"), {repeating = true, locked = true})
hl.bind(keys("XF86AudioMute"), hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), {locked = true})
hl.bind(keys("XF86AudioMicMute"), hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), {locked = true})

hl.bind(keys("XF86AudioPlay"), hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), {locked = true})
hl.bind(keys("XF86AudioPause"), hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), {locked = true})
hl.bind(keys("XF86AudioNext"), hl.dsp.exec_cmd("swayosd-client --playerctl next"), {locked = true})
hl.bind(keys("XF86AudioPrev"), hl.dsp.exec_cmd("swayosd-client --playerctl prev"), {locked = true})

hl.bind(keys("XF86MonBrightnessDown"), hl.dsp.exec_cmd("swayosd-client --brightness lower"), {repeating = true, locked = true})
hl.bind(keys("XF86MonBrightnessUp"), hl.dsp.exec_cmd("swayosd-client --brightness raise"), {repeating = true, locked = true})
