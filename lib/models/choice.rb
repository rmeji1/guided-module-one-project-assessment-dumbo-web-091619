
class Choice < ActiveRecord::Base
    include OptionModule::Options
    has_one :fight
    belongs_to :character
    belongs_to :result
    has_one :monster, through: :fight

    @@options = OPTIONS

    def self.create(args)
        choice = super
        add_option_to(choice)
        if_option_fight_create(choice)
        return choice
    end

    def self.add_option_to(choice)
        temp_option = @@options.sample
        while temp_option == choice.character.previous_choice_option
            temp_option = @@options.sample
        end
        choice.update(option: temp_option)
        choice.character.previous_choice_option = temp_option
    end

    def self.if_option_fight_create(choice)
        if choice.option == FIGHT
            fight = Fight.create(monster: Monster.get_monster_that_hasnt_fought(choice.character))
            choice.update(fight: fight)
            choice.reload
        end
    end

    def show_menu
        system "clear"
        prompt = ChoiceInterface.new(self)
        prompt_return = prompt.show(option)
        self.update(choice_made: prompt_return)
    end

end