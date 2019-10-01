require 'tty-prompt'
require_relative 'OptionModule'
class Game < ActiveRecord::Base
    include OptionModule::Options,  OptionModule::FightChoices
    belongs_to :user
    attr_reader :character_old_health
    
    @@prompt = TTY::Prompt.new

    def character_list
        list = true
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
        system "clear"
        @@prompt.select("Please select what you like to do") do |menu|
            menu.choice "Start Game", -> {start_game}
            menu.choice "Look at your characters", -> {character_list}
            menu.choice "Edit your info", -> {user.update_user(self)}
            menu.choice "Delete your profile", -> {user.delete_user}
            menu.choice "Exit", -> { exit }
        end
    end

    def start_game
        character_id = pick_character
        character = Character.find(character_id)
        begin_game_for_character(character)
    end

    def begin_game_for_character(character)
        # system "clear"
        character_old_health = character.health
        puts "character_old_health = #{character_old_health} "
        start = @@prompt.select("You're standing in the middle of a dense forest. There are four paths: one going north, one going east, one going south, and one going west. Which path do you take?") do |prompt|
            prompt.choice NORTH
            prompt.choice EAST
            prompt.choice SOUTH
            prompt.choice WEST
          end          

          while character.choices.count < 10 do
            puts "Character health beginning while loop = #{character.reload.health}"
            choice = Choice.create(character: character)
            choice.show_menu
            result = Result.create(choice: choice)
            if result.outcome
              puts "Oh no you lost"
              sleep 3
              break
            end
          end   
          
          if character.choices.count == 10
            puts "\n\nYou won the game!!!!\n\n\n"
            sleep 4
          end
          
          character.choices.delete_all
          character.update(health: character_old_health)
          character.reload
          menu
    end

    # def reset_character_stats(character)
    #     puts "Should be changing the god damn health!"
    #     p character.update(health: character_old_health)
    #     character.choices.delete_all
    # end
    

end