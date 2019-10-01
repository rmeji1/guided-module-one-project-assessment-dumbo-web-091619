class User < ActiveRecord::Base
    has_many :characters
    has_many :choices, through: :characters
    has_many :games
    has_many :fights, through: :choices
    has_many :monsters, through: :fights
    
    @@prompt = TTY::Prompt.new
    

    def self.create_user
        new_username = @@prompt.ask("What username would you like to have?")
        User.create(username: new_username)
    end

    def self.find_user
        returning_username = @@prompt.ask("What is your username?")
        user_found = self.find_by(username: returning_username)
        if user_found == nil
           new_user = @@prompt.yes?("I'm sorry, we can't find your username. Would you like to create a new username?")
           if new_user == true
            self.create_user
           else
            puts "See you later"
            exit
           end
        else
            puts "Welcome back, #{user_found.username}."
        end
        user_found
    end

    def update_user
        change_name = @@prompt.ask("What would you like your new username to be?")
        self.update(username: change_name)
        puts "Your username is now #{change_name}"
    end

    def delete_user
        delete = @@prompt.yes?("Are you sure you want to delete your user?")
        if delete == true
            self.delete
            exit
        end
    end

    def list_characters
        self.characters
    end

end