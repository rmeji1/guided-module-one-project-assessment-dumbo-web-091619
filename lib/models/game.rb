require 'tty-prompt'

class Game < ActiveRecord::Base
    belongs_to :user

    @@prompt = TTY::Prompt.new

    def character_list
        list = @@prompt.yes?("Would you like to see your characters?")
        if list == true
            user_characters = user.characters.map(&:name)
            if user_characters.empty?
                puts "You don't have any characters."
                new_character = @@prompt.ask?("Would you like to create a new character?")
                if new_character == true
                    Character.create_character
                end
            else
                puts user_characters
            end
        else
            puts "Exit"
        end
        user_characters
    end

    def pick_character
        @@prompt.select("Which character would you like to use?", user.characters.map{|character| {character.name => character.id}})      
    end

    # def run
    #     character_list
    #     pick_character
    # end

    def menu
    end



    

end