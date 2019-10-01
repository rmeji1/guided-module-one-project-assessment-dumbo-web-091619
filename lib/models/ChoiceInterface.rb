require_relative "OptionModule"
class ChoiceInterface 
  include OptionModule::Options, OptionModule::FoutainChoices,  OptionModule::FightChoices
  attr_reader :prompt
  def initialize
    @prompt =  TTY::Prompt.new
  end
  
  def show(option)
    menu = menu_options
    case option
    when FIGHT
      @prompt.select(menu_options[:FIGHT].prompt, menu_options[:FIGHT].options)
    when FOUNTION
      prompt.select(menu[:FOUNTION].prompt, menu[:FOUNTION].options)
    when GO_AGAIN
      prompt.say("Lucky! Contiune!")
    else
    end 
  end

  def menu_options
    {
      FIGHT: Menu.new(prompt:"Oh no! You see an ogre in front of you. Do you fight or run away?",
              options:[FIGHT_CHOICE, RUN]),
      FOUNTION: Menu.new(prompt:"You have come across the fountian of youth! Would you like to", 
              options: [DRINK, WALK_AWAY])
    }
  end
end