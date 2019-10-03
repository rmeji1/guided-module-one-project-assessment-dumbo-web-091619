
class Choice < ActiveRecord::Base
    include OptionModule::Options
    has_one :fight
    belongs_to :character
    belongs_to :result
    has_one :monster, through: :fight

    @@options = OPTIONS

    def self.create(args)
        system "clear"
        choice = super
        temp_option = self.select_option
        # binding.pry

        while temp_option == choice.character.previous_choice_option
            temp_option = self.select_option
        end
        choice.update(option: temp_option)
        choice.character.previous_choice_option = temp_option
        if choice.option == FIGHT
            fight = Fight.create(monster: Monster.get_monster_that_hasnt_fought(choice.character))
            choice.update(fight: fight)
            choice.reload
        end

        return choice
    end

    def self.select_option
        @@options.sample
        # FRIEND_OR_FOE
        # CAVE
        # FIGHT
    end

    def show_menu
        prompt = ChoiceInterface.new(self)
        prompt_return = prompt.show(option)
        self.update(choice_made: prompt_return)
    end

end