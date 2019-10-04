class Result < ActiveRecord::Base
    include OptionModule::Options, OptionModule::FriendOrFoe,  OptionModule::FightChoices, OptionModule::RiverChoices, OptionModule::CaveChoices

    has_one :choice
    has_one :monster, through: :choice
    has_one :character, through: :choice
    has_many :fights, through: :choice

    attr_accessor :character_health

    ## Health is not resetting after each game
    def outcome
        case choice.option
        when FIGHT
            option_is_fight(choice.choice_made)
        when FRIEND_OR_FOE
            option_is_friend_or_foe(choice.choice_made)
        when RIVER 
            option_is_river(choice.choice_made)
        when CAVE
            option_is_cave(choice.choice_made)
        end
        character.save
        return did_lose?
        sleep 5
    end
    
    def option_is_fight(choice_made)
        choice_made == FIGHT_CHOICE ? self.fight! : self.run!
        sleep 2
        if did_win? 
            puts "Yay! You defeated the #{monster.name}! Onto the next adventure.\n\n"
            sleep 2
        end
    end
    
    def option_is_friend_or_foe(choice_made)
        message = "You don't trust the stranger. You run away.\n\n"
        choice_made == FRIEND_TRUST ? betray_or_help() : (puts message)
        sleep 2
    end

    def option_is_river(choice_made)
        message = "You are able to walk around the river and keep going.\n\n"
        choice_made == RIVER_WALK_AROUND ? (puts message) : succeed_or_die
        sleep 2
    end

    def option_is_cave(choice_made)
        message = "You decide to keep walking.\n\n"
        choice_made == CAVE_CHECKOUT ? help_or_hurt : (puts message)
        sleep 2
    end

    def fight!        
        while monster.health > 0 && character.current_health > 0
            monster_hits
            character_hits unless character.current_health < 1
        end
        self.update(did_win?: true) unless monster.health > 1
        sleep 2
    end
    
    def hit_or_miss?
        rand(2) == 1 ? true : false
    end

    def monster_hits
        puts "\n\nThe #{monster.name} tries to attack you."
        sleep 2
        hit_or_miss? ? monster_gets_to_hit_character : (puts "The #{monster.name} missed!")
        sleep 1
    end

    def monster_gets_to_hit_character
        put("Oh, no the #{monster.name} hits you for #{monster.fight_damage}", :bright_red)
        character.current_health -= monster.fight_damage
        if character.current_health > 0
            puts "Your health is now at #{character.current_health}"
        end
    end

    def character_hits
        puts "\n\nYou try to attack the #{monster.name}." 
        sleep 2
        hit_or_miss? ? character_gets_to_hit_monster : (puts "You missed!")
        sleep 1
    end

    def character_gets_to_hit_monster
        character.class_type == "Warrior" ? warrior_hits : mage_hits
        monster.health -= character.strength
        puts "The #{monster.name}'s health is now at #{monster.health}"
    end

    def warrior_hits
        GameRunner.play("sword.mov")
        put("You hit the #{monster.name} with a sword for #{character.strength} points.", :bright_blue)
    end

    def mage_hits
        GameRunner.play("fireball.mov")
        put("You hit the #{monster.name} with a fireball for #{character.strength} points.", :bright_blue)
    end

    def run!
        put("You tried to run away, but the #{monster.name} hit you for #{monster.run_damage} points", :red)
        character.current_health -= monster.run_damage
        puts "Your health is now at #{character.current_health}\n\n"
        sleep 2
    end

    def did_lose?
        return true unless character.current_health > 0 
        return false
    end

    def put(message, color)
        prompt = TTY::Prompt.new
        prompt.say(message, color: color)
    end
 
    def betray_or_help
        if hit_or_miss?
            character.current_health += 5
            put("The stranger gives you a potion that heals you for 5 points! \n\n", :bright_blue)
        else 
            character.current_health -= 5
            put("Oh no! The stranger attacks you and hits you for 5 damage.\n\n", :bright_red) 
        end   
        puts "Your health is now #{character.current_health}.\n\n"  
    end

    def succeed_or_die
        if hit_or_miss?
            put("You are able to clear the river!\n\n", :bright_blue)
        else 
            put("You try to jump over the river, but you fall and hit your head on a rock. You die.\n\n", :bright_red)
            character.current_health = 0
        end   
        puts "Your health is now #{character.current_health}.\n\n"  
    end

    def help_or_hurt
        if hit_or_miss?
            put("You check out the cave and find a health potion that heals you for 10 points.\n\n", :bright_blue) 
            character.current_health += 10
        else 
            character.current_health -= 10
            put("You walk inside the cave and a giant spider attacks you for 10 damage.\n\n", :bright_red) 
        end   
        puts "Your health is now #{character.current_health}.\n\n"  
    end
end