require_relative '../config/environment'
require 'tty-prompt'
require 'tty-spinner'


class GameRunner 

    def initialize
        @prompt = TTY::Prompt.new
    end
    
    def welcome
        puts "Welcome to our game!"
    end
    
    def played_before
        have_they_played_before = @prompt.yes?("Have you played this game before?")
        if have_they_played_before == true
            User.find_user
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
        # game.menu
        # contiune_game = true
        game.menu
        # while contiune_game 
        # end
    end
end

GameRunner.new.run



# puts dragon_image

# puts "Run Goodbye"
