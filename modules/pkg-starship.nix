{ ... }: {
  programs.starship = {
    enable = true;

    settings = {
      format = "$username:$hostname $directory $git_branch$git_status$character";
      command_timeout = 5000;

      username = {
        show_always = true;
        style_user = "bold blue";
        style_root = "bold red";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = "bold yellow";
        format = "[$hostname]($style)";
      };

      directory = {
        style = "bold cyan";
        format = "[$path]($style)";
        truncation_length = 3;
        truncation_symbol = ".../";
      };

      git_branch = {
        symbol = "git:";
        style = "bold purple";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold red";
        format = "([$all_status$ahead_behind]($style) )";
      };

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };

      time.disabled = true;
      package.disabled = true;
    };
  };
}
