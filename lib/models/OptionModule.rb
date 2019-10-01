module OptionModule
  module Options
    FIGHT = "fight"
    FOUNTION = "fountain"
    GO_AGAIN = "go_again"
    
    private_constant :FIGHT, :FOUNTION, :GO_AGAIN
  end

  module FoutainChoices
    DRINK = "Drink!"
    WALK_AWAY = "Leave the water alone!"
  end

  module FightChoices
    FIGHT_CHOICE = "Fight!"
    RUN = "Run away!"
  end
end