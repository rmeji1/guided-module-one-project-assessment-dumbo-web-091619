class Result < ActiveRecord::Base
    include OptionModule::Options, OptionModule::FriendOrFoe,  OptionModule::FightChoices, OptionModule::RiverChoices

    has_one :choice
    has_one :monster, through: :choice
    has_one :character, through: :choice
    has_many :fights, through: :choice

    attr_accessor :character_health
    def outcome
        case choice.option
        when FIGHT
            option_is_fight(choice.choice_made)
            if did_win? 
                puts "Yay! You defeated the monster! Onto the next adventure.\n"
            end
        when FRIEND_OR_FOE
            option_is_friend_or_foe(choice.choice_made)
        when RIVER 
            option_is_river(choice.choice_made)
        end
        puts "Health inside end of result #{character.health}"
        character.save
        # character_health = character.health
        return did_lose?
    end
    
    def option_is_fight(choice_made)
        case choice_made
        when FIGHT_CHOICE
            self.fight!
        when RUN
            self.run!
        end
    end
    
    def option_is_friend_or_foe(choice_made)
        case choice_made
        when FRIEND_TRUST
            if hit_or_miss?
                character.health += 5
                puts "The stranger gives you a potion that heals you for 5 points! \n\n" 
            else 
                character.health -= 5
                puts "Oh no! The stranger attacks you and hits you for 5 damage.\n\n"    
            end   
            puts "Your health is now #{character.health}."  
        when FRIEND_RUN_AWAY
            puts "You don't trust the stranger you ran away.\n\n"
        end
    end

    def option_is_river(choice_made)
        case choice_made
        when RIVER_WALK_AROUND
           puts "You are able to walk around the river and keep going.\n\n"
        when RIVER_JUMP_OVER
            puts "You try to jump over the river, but you fall and hit your head on a rock. You die.\n\n"
            character.health = 0
        end
    end

    def fight!
        while monster.health > 0 && character.health > 0
            monster_hits
            character_hits unless character.health < 1
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
        puts "\n\nThe monster swings at you."
        sleep 2
        if hit_or_miss?
            puts "Oh, no #{monster.name} hits you for #{monster.fight_damage}"
            character.health = character.health - monster.fight_damage
            puts "Your health is now at #{character.health}"
        else
            puts "The monster missed!"
        end
        sleep 1
    end

    def character_hits
        puts "\n\nYou try to hit the monster." 
        sleep 2
        if hit_or_miss?
            case character.class_type
            when "Warrior"
                puts "You hit the monster with a sword for #{character.strength} points."
            when "Mage"
                puts "You hit the monster with a fireball for #{character.strength} points."
            end
            monster.health -= character.strength
            puts "Monster health is now at #{monster.health}"
        else
            puts "You missed!"
        end

        sleep 1
    end

    def run!
        puts "You tried to run away, but the monster got to you for #{monster.run_damage}"
        character.health = character.health - monster.run_damage
        puts "Your health is now at #{character.health}\n\n"
    end


    def did_lose?
        return true unless character.health > 1 
        return false
    end
end