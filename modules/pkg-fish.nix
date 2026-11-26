{ pkgs, ... }: {
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      function cpg
        if test -d "$argv[2]"
          cp $argv[1] $argv[2]
          cd $argv[2]
        else
          cp $argv[1] $argv[2]
        end
      end

      function mvg
        if test -d "$argv[2]"
          mv $argv[1] $argv[2]
          cd $argv[2]
        else
          mv $argv[1] $argv[2]
        end
      end

      function mkdirg
        mkdir -p $argv[1]
        cd $argv[1]
      end

      function up
        set -l limit $argv[1]
        set -l path ""
        for i in (seq $limit)
          set path $path/..
        end
        cd $path
      end

      function trim
        set -l var (string join " " $argv)
        set var (string trim $var)
        echo -n $var
      end
    '';
  };
}
