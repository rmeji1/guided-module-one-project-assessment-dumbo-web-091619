require_relative '../config/environment'
require_relative '../lib/models/ArtModule'
require 'tty-prompt'
require 'tty-spinner'


class GameRunner 
    include ArtModule

    def initialize
        @prompt = TTY::Prompt.new
    end  
        
    def run
        welcome
        user = played_before
        self.loading_screen
        self.class.kill_all_sounds
        Game.create(user:user).menu
    end

    def welcome
        self.class.play("forest_trim.mov")
        sleep 0.5
        puts "WELCOME TO \n #{FOREST_FIGHTER_LOGO}"
    end
    
    def played_before
        have_they_played_before = @prompt.yes?("Have you played this game before?")
        if have_they_played_before == true
            return User.find_user
        else
            user = User.create_user
            character = Character.create_character(user)
            return user
        end
    end

    def loading_screen
        sleep 3
        system "clear"
        spinner = TTY::Spinner.new("Loading main menu ... [:spinner]", format: :arrow_pulse)
        spinner.auto_spin # Automatic animation with default interval
        sleep 3
        spinner.stop('Done!')
    end

    def self.kill_all_sounds
        pid = fork { `killall afplay` }
        Process.detach(pid)
    end

    def self.exit
        exec "killall afplay"
        exit
    end

    def self.play(title) 
        pid = fork { `afplay music/#{title}` }
        Process.detach(pid)
    end
end

GameRunner.new.run