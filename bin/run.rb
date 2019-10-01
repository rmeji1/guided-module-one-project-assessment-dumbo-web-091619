require_relative '../config/environment'
require 'tty-prompt'

@prompt = TTY::Prompt.new


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

while true do
    welcome
    user = played_before
    
    game = Game.create(user:user)
    # game.menu
    # contiune_game = true
    game.menu
    # while contiune_game 
    # end

end


# get characterthey want to start game 
# 
# if "view_ca"
# binding.pry


puts "Run Goodbye"
