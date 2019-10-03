require 'tty-prompt'
require_relative 'OptionModule'
require_relative 'ArtModule'
class Game < ActiveRecord::Base
    include OptionModule::Options,  OptionModule::FightChoices, ArtModule
    belongs_to :user
    attr_reader :character_old_health
    
    @@prompt = TTY::Prompt.new

    def character_list
        user.reload
        list = true
        if list == true
            user_characters = user.characters.map do |character|
                {character.name => character.id}
            end 
            user_characters << {"Go Back!" => -1}
            user_input = @@prompt.select("Select a character to view stats, or go back to the main menu", user_characters)
            
            if user_input == -1 
                self.menu
            else
                Character.read_stats(Character.find(user_input))
                prompt_to_go_to_main_menu
            end
            binding.pry 
        else
            puts "Exit"
        end
        self.menu
    end

    def prompt_to_go_to_main_menu
        @@prompt.select("", ["Go back to main menu"])
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
        # system "clear"
        character.update(current_health: character.max_health)
        character.previous_choice_option = "fight"
        puts FOREST_IMAGE
        start = @@prompt.select("You're standing in the middle of a dense forest. There are four paths: one going north, one going east, one going south, and one going west. Which path do you take?") do |prompt|
            prompt.choice NORTH
            prompt.choice EAST
            prompt.choice SOUTH
            prompt.choice WEST
          end          

          while character.choices.count < 10 && character.current_health > 1 do
            choice = Choice.create(character: character)
            choice.show_menu
            result = Result.create(choice: choice)
            if result.outcome
            lost = <<-ASCII

▓██   ██▓ ▒█████   █    ██     ██▓     ▒█████    ██████ ▄▄▄█████▓ ▐██▌  ▐██▌  ▐██▌ 
▒██  ██▒▒██▒  ██▒ ██  ▓██▒   ▓██▒    ▒██▒  ██▒▒██    ▒ ▓  ██▒ ▓▒ ▐██▌  ▐██▌  ▐██▌ 
 ▒██ ██░▒██░  ██▒▓██  ▒██░   ▒██░    ▒██░  ██▒░ ▓██▄   ▒ ▓██░ ▒░ ▐██▌  ▐██▌  ▐██▌ 
 ░ ▐██▓░▒██   ██░▓▓█  ░██░   ▒██░    ▒██   ██░  ▒   ██▒░ ▓██▓ ░  ▓██▒  ▓██▒  ▓██▒ 
 ░ ██▒▓░░ ████▓▒░▒▒█████▓    ░██████▒░ ████▓▒░▒██████▒▒  ▒██▒ ░  ▒▄▄   ▒▄▄   ▒▄▄  
  ██▒▒▒ ░ ▒░▒░▒░ ░▒▓▒ ▒ ▒    ░ ▒░▓  ░░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░  ▒ ░░    ░▀▀▒  ░▀▀▒  ░▀▀▒ 
▓██ ░▒░   ░ ▒ ▒░ ░░▒░ ░ ░    ░ ░ ▒  ░  ░ ▒ ▒░ ░ ░▒  ░ ░    ░     ░  ░  ░  ░  ░  ░ 
▒ ▒ ░░  ░ ░ ░ ▒   ░░░ ░ ░      ░ ░   ░ ░ ░ ▒  ░  ░  ░    ░          ░     ░     ░ 
░ ░         ░ ░     ░            ░  ░    ░ ░        ░            ░     ░     ░    
░ ░                                                                               
ASCII
              @@prompt.say(lost, color: :red) 
              user.losses += 1
              user.save
              user.reload
              sleep 3
              break
            end
          end   
          
          if character.choices.count == 10
            you_won = <<-ASCII

            ▓██   ██▓ ▒█████   █    ██     █     █░ ▒█████   ███▄    █  ▐██▌  ▐██▌  ▐██▌ 
            ▒██  ██▒▒██▒  ██▒ ██  ▓██▒   ▓█░ █ ░█░▒██▒  ██▒ ██ ▀█   █  ▐██▌  ▐██▌  ▐██▌ 
             ▒██ ██░▒██░  ██▒▓██  ▒██░   ▒█░ █ ░█ ▒██░  ██▒▓██  ▀█ ██▒ ▐██▌  ▐██▌  ▐██▌ 
             ░ ▐██▓░▒██   ██░▓▓█  ░██░   ░█░ █ ░█ ▒██   ██░▓██▒  ▐▌██▒ ▓██▒  ▓██▒  ▓██▒ 
             ░ ██▒▓░░ ████▓▒░▒▒█████▓    ░░██▒██▓ ░ ████▓▒░▒██░   ▓██░ ▒▄▄   ▒▄▄   ▒▄▄  
              ██▒▒▒ ░ ▒░▒░▒░ ░▒▓▒ ▒ ▒    ░ ▓░▒ ▒  ░ ▒░▒░▒░ ░ ▒░   ▒ ▒  ░▀▀▒  ░▀▀▒  ░▀▀▒ 
            ▓██ ░▒░   ░ ▒ ▒░ ░░▒░ ░ ░      ▒ ░ ░    ░ ▒ ▒░ ░ ░░   ░ ▒░ ░  ░  ░  ░  ░  ░ 
            ▒ ▒ ░░  ░ ░ ░ ▒   ░░░ ░ ░      ░   ░  ░ ░ ░ ▒     ░   ░ ░     ░     ░     ░ 
            ░ ░         ░ ░     ░            ░        ░ ░           ░  ░     ░     ░    
            ░ ░                                                                         
            ASCII

            @@prompt.say(you_won, color: :bright_blue) 
            puts "\n\nYou made it outside of the forest. You're free!\n\n\n"
            user.wins += 1
            user.save
            user.reload
            sleep 4
          end
          
          character.choices.delete_all
          character.reload
          menu
    end
end