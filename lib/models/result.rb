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
            if did_win? 
                puts "Yay! You defeated the #{monster.name}! Onto the next adventure.\n\n"
            end
        when FRIEND_OR_FOE
            option_is_friend_or_foe(choice.choice_made)
        when RIVER 
            option_is_river(choice.choice_made)
        when CAVE
            option_is_cave(choice.choice_made)
        end
        character.save
        return did_lose?
        sleep 2
    end
    
    def option_is_fight(choice_made)
        case choice_made
        when FIGHT_CHOICE
            self.fight!
        when RUN
            self.run!
        end
        sleep 2
    end
    
    def option_is_friend_or_foe(choice_made)
        case choice_made
        when FRIEND_TRUST
            betray_or_help
        when FRIEND_RUN_AWAY
            puts "You don't trust the stranger. You run away.\n\n"
        end
        sleep 2
    end

    def option_is_river(choice_made)
        case choice_made
        when RIVER_WALK_AROUND
           puts "You are able to walk around the river and keep going.\n\n"
        when RIVER_JUMP_OVER
            succeed_or_die
        end
        sleep 2
    end

    def option_is_cave(choice_made)
        case choice_made
        when CAVE_CHECKOUT
            help_or_hurt
        when CAVE_KEEP_WALKING
            puts "You decide to keep walking.\n\n"
        end
        sleep 2
    end

    def fight!        
        while monster.health > 0 && character.current_health > 0
            monster_hits
            character_hits unless character.current_health < 1
        end

        if monster.health < 1
            self.update(did_win?: true)
        end
       
        sleep 2
    end
    
    def hit_or_miss?
        rand(2) == 1 ? true : false
    end

    def monster_hits
        puts "\n\nThe #{monster.name} tries to attack you."
        sleep 2
        if hit_or_miss?
            put("Oh, no the #{monster.name} hits you for #{monster.fight_damage}", :bright_red)
            character.current_health -= monster.fight_damage
            puts "Your health is now at #{character.current_health}"
        else
            puts "The #{monster.name} missed!"
        end
        sleep 1
    end

    def character_hits
        puts "\n\nYou try to attack the #{monster.name}." 
        sleep 2
        if hit_or_miss?
            case character.class_type
            when "Warrior"
                put("You hit the #{monster.name} with a sword for #{character.strength} points.", :bright_blue)
            when "Mage"
                put("You hit the #{monster.name} with a fireball for #{character.strength} points.", :bright_blue)
            end
            monster.health -= character.strength
            puts "The #{monster.name}'s health is now at #{monster.health}"
        else
            puts "You missed!"
        end

        sleep 1
    end

    def run!
        put("You tried to run away, but the #{monster.name} hit you for #{monster.run_damage} points", :red)
        character.current_health -= monster.run_damage
        puts "Your health is now at #{character.current_health}\n\n"
        sleep 2
    end


    def did_lose?
        return true unless character.current_health > 1 
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