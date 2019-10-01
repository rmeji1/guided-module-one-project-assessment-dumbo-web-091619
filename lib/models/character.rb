class Character < ActiveRecord::Base
    belongs_to :user
    has_many :choices
    has_many :results, through: :choices
    has_many :fights, through: :choices
    has_many :monsters, through: :fights

    @@prompt = TTY::Prompt.new

    def self.create_character
        new_name = @@prompt.ask("What would you like to name your character?")
        new_character = Character.create(name: new_name)
        new_class = @@prompt.select("What would you like your class to be?", %w(Warrior Mage))
        new_character.update(class_type: new_class)
            if new_class == "Warrior"
                puts "Roll for health"
                new_health = rand(5..10)
                new_character.update(health: new_health)
                puts "Roll for strength"
                new_strength = rand(1..5)
                new_character.strength = new_strength
            else
                puts "Roll for health"
                new_health = rand(1..5)
                new_character.health = new_health
                puts "Roll for strength"
                new_strength = rand(5..10)
                new_character.strength = new_strength
            end

    end

    def self.find_character
        returning_character = @@prompt.ask("What is the name of your character?")
        find = self.find_by(name: returning_character)
        if find == nil
            new_character = @@prompt.yes?("I'm sorry, we can't find your character. Would you like to create a new character?")
            if new_character == true
                self.create_character
            else
                puts "See you later"
                exit
            end
        end
    end

    def update_character
        change_name = @@prompt.ask("What would you like your new character name to be?")
        self.name = change_name
        puts "Your character name is now #{change_name}"
    end

    def delete_character
        delete = @@prompt.yes?("Are you sure you want to delete your character?")
        if delete == true
            self.delete
        end
    end

end