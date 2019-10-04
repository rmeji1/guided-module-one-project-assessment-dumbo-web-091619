require 'tty-prompt'
require_relative 'OptionModule'
require_relative 'ArtModule'
class Game < ActiveRecord::Base
    include OptionModule::Options,  OptionModule::FightChoices, ArtModule
    belongs_to :user
    attr_reader :character_old_health
    
    @@prompt = TTY::Prompt.new

    def prompt_to_go_to_main_menu
        @@prompt.select("", ["Go back to main menu"])
        self.menu
    end

    def go_back_to_character_list
        @@prompt.select("", ["Go back to main menu"])
        character_list
    end

    def read_stats(character)
        Character.read_stats(character)
        go_back_to_character_list
    end

    def update_character(character)
        Character.update_character(character)
        go_back_to_character_list
    end

    def delete_character(character)
        Character.delete_character(character)
      go_back_to_character_list
    end

    def character_list
        user.reload
        system "clear"
        user_characters = user.characters.map do |character|
            {character.name => character.id}
        end 
        if user_characters.empty?
            yes = @@prompt.yes?("You don't have any characters. Would you like to create a new character?")
            if yes == true
                Character.create_character(user)
            else
                self.menu
            end
        else
            user_characters << {"Go Back!" => -1}
            user_input = @@prompt.select("Select a character to view stats, edit or delete your character, or go back to the main menu", user_characters)
            if user_input == -1 
                self.menu
            else
                character = (Character.find(user_input))
                @@prompt.select("Would you like to view stats, edit, or delete your character?") do |menu|
                menu.choice "Read stats", -> {read_stats(character)}
                menu.choice "Edit your character", -> {update_character(character)}
                menu.choice "Delete your character", -> {delete_character(character)}
                menu.choice "Go back to main menu", -> {prompt_to_go_to_main_menu}
                end
            end
        end
        self.menu
    end

    def pick_character
        user.reload
        @@prompt.select("Which character would you like to use?", user.characters.map{|character| {character.name => character.id}})      
    end

    def create_character
        Character.create_character(user)
        prompt_to_go_to_main_menu
    end

    def view_user_profile
        user.view_profile
        prompt_to_go_to_main_menu
    end
    
    def menu
        system "clear"
        @@prompt.select("Please select what you like to do", per_page: 7) do |menu|
            menu.choice "Start Game", -> {start_game}
            menu.choice "Create a New Character", -> {create_character}
            menu.choice "View Your Characters", -> {character_list}
            menu.choice "View Your Profile", -> {view_user_profile}
            menu.choice "Edit Your Profile", -> {user.update_user(self)}
            menu.choice "Delete Your Profile", -> {user.delete_user}
            menu.choice "Exit", -> { exit }
        end
    end

    def start_game
        character_id = pick_character
        character = Character.find(character_id)
        begin_game_for_character(character)
    end

    def begin_game_for_character(character)
        character.update(current_health: character.max_health)
        character.previous_choice_option = "fight"
        puts FOREST_IMAGE
        start_prompt  
        lost = false
        while character.choices.count < 10 && character.current_health > 1 do
            choice = Choice.create(character: character)
            choice.show_menu
            result = Result.create(choice: choice)
            if result.outcome
                player_lost() 
                lost = true
                break 
            end
        end
        did_win(character, lost)
        character.choices.delete_all
        character.reload
        menu
    end

    def start_prompt
        @@prompt.select("You're standing in the middle of a dense forest. There are four paths: one going north, one going east, one going south, and one going west. Which path do you take?") do |prompt|
            prompt.choice NORTH
            prompt.choice EAST
            prompt.choice SOUTH
            prompt.choice WEST
          end        
    end

    def player_lost
        system "clear"
        @@prompt.say(LOST_IMAGE, color: :red) 
        GameRunner.play("losing.mov")
        sleep 5
        user.losses += 1
        user.save
        user.reload
    end

    def did_win(character, lost)
        if character.choices.count == 10 && !lost
            system "clear"
            @@prompt.say(WON_IMAGE, color: :bright_blue) 
            puts "\n\nYou made it outside of the forest. You're free!\n\n\n"
            GameRunner.play("winning.mov")
            sleep 5
            user.wins += 1
            user.save
            user.reload
          end
    end
end