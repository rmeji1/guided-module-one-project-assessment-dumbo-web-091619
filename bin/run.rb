require_relative '../config/environment'
require 'tty-prompt'
require 'tty-spinner'


class GameRunner 

    @@sounds = {}

    def initialize
        @prompt = TTY::Prompt.new
    end
    
    def welcome
        self.class.play_forest_sound
        sleep 0.5
        puts "WELCOME TO"
        puts <<-ASCII

  █████▒▒█████   ██▀███  ▓█████   ██████ ▄▄▄█████▓     █████▒██▓  ▄████  ██░ ██ ▄▄▄█████▓▓█████  ██▀███  
  ▓██   ▒▒██▒  ██▒▓██ ▒ ██▒▓█   ▀ ▒██    ▒ ▓  ██▒ ▓▒   ▓██   ▒▓██▒ ██▒ ▀█▒▓██░ ██▒▓  ██▒ ▓▒▓█   ▀ ▓██ ▒ ██▒
  ▒████ ░▒██░  ██▒▓██ ░▄█ ▒▒███   ░ ▓██▄   ▒ ▓██░ ▒░   ▒████ ░▒██▒▒██░▄▄▄░▒██▀▀██░▒ ▓██░ ▒░▒███   ▓██ ░▄█ ▒
  ░▓█▒  ░▒██   ██░▒██▀▀█▄  ▒▓█  ▄   ▒   ██▒░ ▓██▓ ░    ░▓█▒  ░░██░░▓█  ██▓░▓█ ░██ ░ ▓██▓ ░ ▒▓█  ▄ ▒██▀▀█▄  
  ░▒█░   ░ ████▓▒░░██▓ ▒██▒░▒████▒▒██████▒▒  ▒██▒ ░    ░▒█░   ░██░░▒▓███▀▒░▓█▒░██▓  ▒██▒ ░ ░▒████▒░██▓ ▒██▒
   ▒ ░   ░ ▒░▒░▒░ ░ ▒▓ ░▒▓░░░ ▒░ ░▒ ▒▓▒ ▒ ░  ▒ ░░       ▒ ░   ░▓   ░▒   ▒  ▒ ░░▒░▒  ▒ ░░   ░░ ▒░ ░░ ▒▓ ░▒▓░
   ░       ░ ▒ ▒░   ░▒ ░ ▒░ ░ ░  ░░ ░▒  ░ ░    ░        ░      ▒ ░  ░   ░  ▒ ░▒░ ░    ░     ░ ░  ░  ░▒ ░ ▒░
   ░ ░   ░ ░ ░ ▒    ░░   ░    ░   ░  ░  ░    ░          ░ ░    ▒ ░░ ░   ░  ░  ░░ ░  ░         ░     ░░   ░ 
             ░ ░     ░        ░  ░      ░                      ░        ░  ░  ░  ░            ░  ░   ░     
                                                                                                           
  ASCII
    end
    
    def played_before
        have_they_played_before = @prompt.yes?("Have you played this game before?")
        if have_they_played_before == true
            user = User.find_user
            return user
        else
            user = User.create_user
            character = Character.create_character(user)
            return user
        end
    end
    
    def run
        welcome
        user = played_before
        sleep 3
        system "clear"
        spinner = TTY::Spinner.new("Loading main menu ... [:spinner]", format: :arrow_pulse)
        spinner.auto_spin # Automatic animation with default interval
        sleep 3
        spinner.stop('Done!')
        game = Game.create(user:user)
        self.class.kill_forest_sound
        game.menu    
    end

    def self.play_forest_sound 
        forest_pid = fork { `afplay music/forest_trim.mov` }
        @@sounds["forest"] = forest_pid
        Process.detach(forest_pid)
    end

    def self.kill_forest_sound
        fork { exec "killall afplay" }
        # Process.kill("SIGHUP", @@sounds["forest"])
    end

    def self.kill_all_sounds
        fork { exec "killall afplay" }
    end

    def self.exit
        self.kill_all_sounds
        exit
    end

    def self.play_demon_noise
        pid = fork { `afplay music/demon.mov` }
        Process.detach(pid)
    end

    def self.play_wolf_noise
        pid = fork { `afplay music/wolf.mp3` }
        Process.detach(pid)
    end

    def self.play_bear_noise
        pid = fork { `afplay music/bear.mov` }
        Process.detach(pid)
    end
    
    def self.play_dragon_noise
        pid = fork { `afplay music/dragon.mov` }
        Process.detach(pid)
    end

    def self.play_ghoul_noise
        pid = fork { `afplay music/ghoul.mov` }
        Process.detach(pid)
    end

    def self.play_ogre_noise
        pid = fork { `afplay music/ogre.m4a` }
        Process.detach(pid)
    end
end

GameRunner.new.run



# puts dragon_image

# puts "Run Goodbye"
