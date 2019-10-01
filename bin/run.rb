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
        User.create_user
    end
end

welcome
user = played_before

game1 = Game.create(user:user)
game1.run

binding.pry


puts "Run Goodbye"
