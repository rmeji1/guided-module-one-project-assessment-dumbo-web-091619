
class Choice < ActiveRecord::Base
    include OptionModule::Options
    has_one :fight
    belongs_to :character
    belongs_to :result
    has_one :monster, through: :fight

    @@options = OPTIONS

    def self.create(args)
        choice = super
        choice.update(option: self.select_option)
        if choice.option == FIGHT
            fight = Fight.create(monster: Monster.get_monster_that_hasnt_fought(choice.character))
            choice.update(fight: fight)
        end
        return choice
    end

    def self.select_option
        @@options.sample
        # FRIEND_OR_FOE
        # CAVE
    end

    def show_menu
        prompt = ChoiceInterface.new()
        prompt_return = prompt.show(option)
        self.update(choice_made: prompt_return)
    end

end