class Character < ActiveRecord::Base
    belongs_to :user
    has_many :choices
    has_many :results, through: :choices
    has_many :fights, through: :choices
    has_many :monsters, through: :fights

    attr_accessor :previous_choice_option

    @@prompt = TTY::Prompt.new


    def self.create_character(user)
        new_name = @@prompt.ask("What would you like to name your character?")
        new_character = Character.create(name: new_name, user: user)
        new_class = @@prompt.select("What would you like your class to be?", %w(Warrior Mage))
        new_character.update(class_type: new_class)
        add_health_and_strength(new_character, new_class)
        sleep 1
        new_character
    end

    def self.add_health_and_strength(new_character, new_class)
        if new_class == "Warrior"
            puts "Roll for health"
            new_health = rand(50..70)
            new_character.update(max_health: new_health)
            sleep 1
            puts "Your health is #{new_health}"
            puts "Roll for strength"
            new_strength = rand(5..10)
            new_character.update(strength: new_strength)
            sleep 1
            puts "Your strength is #{new_strength}"
        else
            puts "Roll for health"
            new_health = rand(40..60)
            new_character.update(max_health: new_health)
            sleep 1
            puts "Your health is #{new_health}"
            puts "Roll for strength"
            new_strength = rand(10..15)
            new_character.update(strength: new_strength)
            sleep 1
            puts "Your strength is #{new_strength}"
        end
    end

    def self.find_character
        returning_character = @@prompt.ask("What is the name of your character?")
        
        found_character = self.find_by(name: returning_character)
        # binding.pry
        if found_character == nil
            new_character = @@prompt.yes?("I'm sorry, we can't find your character. Would you like to create a new character?")
            if new_character == true
                self.create_character
            else
                puts "See you later"
                exit
            end
        else
            puts "Welcome back #{returning_character}"
        end
        found_character
    end

    def self.read_stats(found_character)
        puts "Here are your stats:"
        puts "Your name is #{found_character.name}"
        puts "Your class is #{found_character.class_type}"
        puts "Your health is #{found_character.max_health}"
        puts "Your strength is #{found_character.strength}"
    end

    def self.update_character(found_character)
        change_name = @@prompt.ask("What would you like your new character name to be?")
        found_character.update(name: change_name) 
        puts "Your character name is now #{change_name}"
    end

    def self.delete_character(found_character)
        delete = @@prompt.yes?("Are you sure you want to delete your character?")
        if delete == true
            found_character.delete
        end
    end

end