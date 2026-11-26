{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "dbrada";
        email = "bradadavidcz@gmail.com";
      };
    };
  };
}
