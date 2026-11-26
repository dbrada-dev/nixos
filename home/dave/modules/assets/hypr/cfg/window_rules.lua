-- █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█  █▀█ █░█ █░░ █▀▀ █▀
-- ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀  █▀▄ █▄█ █▄▄ ██▄ ▄█
hl.window_rule({
    name  = "suppress-maximize-events",
    match = {class = ".*"},
    suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false,},
  no_focus = true,
})

hl.window_rule({name = "float-file-progress", match = {title = "file_progress"}, float = true,})
hl.window_rule({name = "float-confirm", match = {title = "confirm"}, float = true,})
hl.window_rule({name = "float-dialog", match = {title = "dialog"}, float = true,})
hl.window_rule({name = "float-download", match = {title = "download"}, float = true,})
hl.window_rule({name = "float-notification", match = {title = "notification"}, float = true,})
hl.window_rule({name = "float-error", match = {title = "error"}, float = true,})
hl.window_rule({name = "float-splash", match = {title = "splash"}, float = true,})
hl.window_rule({name = "float-confirmreset", match = {title = "confirmreset"}, float = true,})
hl.window_rule({name = "float-open-file", match = {title = "Open File"}, float = true,})
hl.window_rule({name = "float-branchdialog", match = {title = "branchdialog"}, float = true,})
hl.window_rule({name = "float-lxappearance", match = {title = "Lxappearance"}, float = true,})
hl.window_rule({name = "rofi-rules", match = {title = "Rofi"}, float = true, animation = "none",})
hl.window_rule({name = "float-feh", match = {title = "feh"}, float = true,})
hl.window_rule({name = "float-pavucontrol-qt", match = {title = "pavucontrol-qt"}, float = true,})
hl.window_rule({name = "float-pavucontrol", match = {title = "pavucontrol"}, float = true,})
hl.window_rule({name = "float-file-roller", match = {title = "file-roller"}, float = true,})
hl.window_rule({name = "idle-mpv", match = {title = "mpv"}, idle_inhibit = "focus",})
hl.window_rule({name = "idle-firefox", match = {title = "firefox"}, idle_inhibit = "fullscreen",})
hl.window_rule({name = "float-media-viewer", match = {title = "^(Media viewer)$"}, float = true,})
hl.window_rule({name = "volume-control-rules", match = {title = "^(Volume Control)$"}, float = true, size = "800 600", move = "75 44%",})
hl.window_rule({name = "float-pip", match = {title = "^(Picture-in-Picture)$"}, float = true,})
