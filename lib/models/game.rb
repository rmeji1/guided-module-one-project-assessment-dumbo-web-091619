require 'tty-prompt'

class Game < ActiveRecord::Base
    belongs_to :user

    # @@prompt = TTY::Prompt.new
    
    # puts "Welcome to our game!"
    # puts User.all

    # played_before = @@prompt.yes?("Have you played this game before?")

    # if played_before == true
    #         Ureturning_username = @@prompt.ask("What is your username?")
    #         User.find_by(username: returning_username)
    #         if User.find_user != nil
    #             puts "Welcome back, #{User.find_user.username}!"
    #         else
    #             no_user = @@prompt.yes?("I'm sorry, I can't find you in the database. Would you like to create a new user?")
    #             if no_user == true
    #                 User.create_user
    #             else
    #                 puts "See you later"
    #                 exit
    #             end
    #         end
    #     else
    #         User.create_user
    #     end


    

end