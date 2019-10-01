class Result < ActiveRecord::Base
    include OptionModule::Options, OptionModule::FoutainChoices,  OptionModule::FightChoices

    has_one :choice
    has_one :character, through: :choice
    has_many :fights, through: :choice

    def outcome
        p choice.option
        p choice.choice_made
        case choice.option
        when FIGHT
            option_is_fight(choice.choice_made)
        when FOUNTION
            puts "Do work here when choice option == fountion"
        end
    end
    
    private 
    def option_is_fight(choice_made)
        case choice_made
        when FIGHT_CHOICE
            puts "Add method here that takes away points from user or monster. Maybe?"
        when RUN
            puts "Character is scared and decided to run! HAHAHA!"
        end
    end
end