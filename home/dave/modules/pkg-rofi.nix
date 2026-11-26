{ ... }: {
  programs.rofi = {
    enable = true;
  };

  xdg.configFile."rofi/shared/colors.rasi".text = ''
    @import "~/.config/rofi/colors/dark.rasi"
  '';

  xdg.configFile."rofi/shared/fonts.rasi".text = ''
    * {
        font: "JetBrainsMono Nerd Font Mono 10";
    }
  '';

  xdg.configFile."rofi/colors/dark.rasi".text = ''
    * {
        background:     #000000FF;
        background-alt: #11111BFF;
        border-color:   #1A1A1AFF;
        foreground:     #E0E0E0FF;
        selected:       #EBA0ACFF;
        selected-text:  #000000FF;
        active:         #A6E3A1FF;
        urgent:         #E06C75FF;
    }
  '';

  xdg.configFile."rofi/config.rasi".text = ''
    /*****----- Configuration -----*****/
    configuration {
        modi:                       "drun";
        show-icons:                 true;
        icon-theme:                 "WhiteSur";
        display-drun:               "";
        display-run:                "";
        display-filebrowser:        "";
        display-window:             "";
        drun-display-format:        "{name}";
        window-format:              "{t}";
    }

    /*****----- Global Properties -----*****/
    @import                         "shared/colors.rasi"
    @import                         "shared/fonts.rasi"

    /*****----- Main Window -----*****/
    window {
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  false;
        width:                       650px;
        x-offset:                    0px;
        y-offset:                    0px;

        enabled:                     true;
        margin:                      0px;
        padding:                     14px;
        border:                      1px solid;
        border-radius:               12px;
        border-color:                @border-color;
        background-color:            @background;
        cursor:                      "default";
    }

    /*****----- Main Box -----*****/
    mainbox {
        enabled:                     true;
        spacing:                     12px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        background-color:            transparent;
        children:                    [ "inputbar", "listview" ];
    }

    /*****----- Inputbar -----*****/
    inputbar {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     10px 14px;
        border:                      1px solid;
        border-radius:               8px;
        border-color:                @border-color;
        background-color:            @background-alt;
        text-color:                  @foreground;
        children:                    [ "prompt", "entry" ];
    }

    prompt {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  @selected;
    }

    entry {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
        cursor:                      text;
        placeholder:                 "Search...";
        placeholder-color:           #585b70;
    }

    /*****----- Listview -----*****/
    listview {
        enabled:                     true;
        columns:                     1;
        lines:                       6;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   false;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;

        spacing:                     6px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        background-color:            transparent;
        text-color:                  @foreground;
        cursor:                      "default";
    }

    /*****----- Elements -----*****/
    element {
        enabled:                     true;
        spacing:                     12px;
        margin:                      0px;
        padding:                     8px 12px;
        border:                      0px solid;
        border-radius:               8px;
        background-color:            transparent;
        text-color:                  @foreground;
        cursor:                      pointer;
    }

    element normal.normal,
    element alternate.normal {
        background-color:            transparent;
        text-color:                  @foreground;
    }

    /* Active Selection Highlight */
    element selected.normal,
    element selected.alternate {
        background-color:            @selected;
        text-color:                  @selected-text;
    }

    element-icon {
        background-color:            transparent;
        text-color:                  inherit;
        size:                        28px;
        cursor:                      inherit;
    }

    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        highlight:                   inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }

    /*****----- Message -----*****/
    error-message {
        padding:                     15px;
        border:                      1px solid;
        border-radius:               8px;
        border-color:                @urgent;
        background-color:            @background;
        text-color:                  @foreground;
    }

    textbox {
        background-color:            @background;
        text-color:                  @foreground;
        vertical-align:              0.5;
        horizontal-align:            0.0;
        highlight:                   none;
    }
  '';
}
