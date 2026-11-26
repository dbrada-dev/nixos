{ ... }: {
  programs.fish = {
    enable = true;

    loginShellInit = ''
      if test -z "$DISPLAY" -a -z "$WAYLAND_DISPLAY" -a (tty) = "/dev/tty1"
        exec start-hyprland
      end
    '';

    interactiveShellInit = ''
      set -g fish_greeting ""

      set -x LESS_TERMCAP_mb (printf '\e[01;31m')
      set -x LESS_TERMCAP_md (printf '\e[01;31m')
      set -x LESS_TERMCAP_me (printf '\e[0m')
      set -x LESS_TERMCAP_se (printf '\e[0m')
      set -x LESS_TERMCAP_so (printf '\e[01;44;33m')
      set -x LESS_TERMCAP_ue (printf '\e[0m')
      set -x LESS_TERMCAP_us (printf '\e[01;32m')

      stty -ixon

      if status is-interactive && test "$TERM_PROGRAM" != "vscode" && test "$TERM" != "xterm-256color"
        fastfetch

        function cd
          if set -q argv[1]
            z $argv; and ls
          else
            z ~; and ls
          end
        end
      end
      
      rm -rf ~/.temp_session

      function update-git
        sudo git -C /etc/nixos add -A
        and sudo -E git -C /etc/nixos commit $argv
        and sudo nixos-rebuild switch
      end

      function agy --description 'Run agy inside a sandbox folder if launched from the home directory'
        if test "$PWD" = "$HOME"
          mkdir -p "$HOME/.gemini/.agy-sb"
          builtin cd "$HOME/.gemini/.agy-sb/"
          command agy $argv
          builtin cd "$HOME"
        else
          command agy $argv
        end
      end

      function extract
        for arg in $argv
          if test -f "$arg"
            bsdtar -xvf "$arg"
          else
            echo "$arg : not a file"
          end
        end
      end

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

      function print_message
        set -l messages \
          "(╯°□°）╯︵ ┻━┻" \
          "¯\_(ツ)_/¯" \
          "ACHTUNG! ALLES TURISTEN UND NONTEKNISCHEN LOOKENPEEPERS! DAS KOMPUTERMASCHINE IST NICHT FÜR DER GEFINGERPOKEN UND MITTENGRABEN! ODERWISE IST EASY TO SCHNAPPEN DER SPRINGENWERK, BLOWENFUSEN UND POPPENCORKEN MIT SPITZENSPARKEN. IST NICHT FÜR GEWERKEN BEI DUMMKOPFEN. DER RUBBERNECKEN SIGHTSEEREN KEEPEN DAS COTTONPICKEN HÄNDER IN DAS POCKETS MUSS. ZO RELAXEN UND WATSCHEN DER BLINKENLICHTEN." \
          "And the Darwin Award goes to.... $USER!" \
          "Allowing you to survive childbirth was medical malpractice." \
          "Are you always this stupid or are you making a special effort today?!" \
          "Are you even trying?!" \
          "Bad." \
          "Boooo!" \
          "Brains aren't everything. In your case they're nothing." \
          "Commands, random gibberish, who cares!" \
          "Come on! You can do it!" \
          "Don't you have anything better to do?!" \
          "Don't you know anything?" \
          "Dropped on your head as a baby, eh?" \
          "error code: 1D10T" \
          "Even your mom loves you only as a friend." \
          "ERROR_INCOMPETENT_USER" \
          "Fake it till you make it!" \
          "Go outside." \
          "Haha, n00b!" \
          "How many times do I have to flush before you go away?" \
          "I am _seriously_ considering 'rm -rf /'-ing myself..." \
          "I don't know what makes you so stupid, but it really works." \
          "I was going to give you a nasty look, but I see you already have one." \
          "If beauty fades then you have nothing to worry about." \
          "If brains were gasoline you wouldn’t have enough to propel a flea’s motorcycle around a doughnut." \
          "If ignorance is bliss, you must be the happiest person on earth." \
          "If shit was music, you'd be an orchestra." \
          "If what you don't know can't hurt you, you're invulnerable." \
          "Incompetence is also a form of competence" \
          "I’d slap you, but that’d be animal abuse." \
          "I’ve heard of being hit with the ugly stick, but you must have been beaten senseless with it." \
          "Keep trying, someday you'll do something intelligent!" \
          "Let’s play horse. I’ll be the front end. And you be yourself." \
          "Life is good, you should get one." \
          "lol" \
          "lol... plz" \
          "My keyboard is not a touch screen!" \
          "My uptime is longer than your relationships." \
          "Nice try." \
          "n00b alert!" \
          "Pathetic" \
          "Perhaps computers are not for you..." \
          "Perhaps you should leave the command line alone..." \
          "Please step away from the keyboard!" \
          "plz uninstall" \
          "Pro tip: type a valid command!" \
          "Rose are red. Violets are blue. I have five fingers. The middle one's for you." \
          "RTFM!" \
          "Sorry what? I don’t understand idiot language." \
          "The degree of your stupidity is enough to boil water." \
          "The worst one today!" \
          "This is not a search engine." \
          "This is not Windows" \
          "This is why nobody likes you." \
          "This is why you get to see your children only once a month." \
          "Try using your brain the next time!" \
          "Two wrongs don't make a right, take your parents as an example." \
          "Typing incorrect commands, eh?" \
          "u suk" \
          "What if... you type an actual command the next time!" \
          "What if I told you... it is possible to type valid commands." \
          "What is this...? Amateur hour!?" \
          "Why are you so stupid?!" \
          "Why are you doing this to me?!" \
          "Why did the chicken cross the road? To get the hell away from you." \
          "Wow! That was impressively wrong!" \
          "Y u no speak computer???" \
          "You are not as bad as people say, you are much, much worse." \
          "You are not useless since you can still be used as a bad example." \
          "You must have been born on a highway because that's where most accidents happen." \
          "Your application for reduced salary has been sent!" \
          "Your mom had a severe case of diarrhea when you were born." \
          "You're proof that god has a sense of humor." \
          "You’re so dumb your first words were DUH." \
          "You're so fat, people jog around you for exercise." \
          "You’re the reason Santa says ho, ho, ho, on Christmas!"

        set -l max (count $messages)
        set -l idx (math (random) % $max + 1)
        set -l msg $messages[$idx]

        set_color --bold red
        echo -e "\n  $msg\n"
        set_color normal
      end

      function __fish_command_not_found_handler --on-event fish_command_not_found
        print_message
        echo "fish: Unknown command: $argv[1]" >&2
        return 127
      end
    '';
  };
}
