-- █▄▄ █▀▀ █░█ ▄▀█ █░█ █ █▀█ █▀█
-- █▄█ ██▄ █▀█ █▀█ ▀▄▀ █ █▄█ █▀▄
hl.config({
  general = {
    resize_on_border = false,
    allow_tearing = false,
  },
  dwindle = {
    preserve_split = true,
  },
  master = {
    new_status = "master",
  },
  scrolling = {
    fullscreen_on_one_column = true,
  },
  input = {
    kb_model   = "",
    kb_options = "caps:swapescape",
    kb_rules   = "",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = false,
      disable_while_typing = false,
    },
    numlock_by_default = true,
  },
})
