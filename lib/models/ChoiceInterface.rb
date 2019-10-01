require_relative "OptionModule"
class ChoiceInterface 
  include OptionModule::Options, OptionModule::FoutainChoices,  OptionModule::FightChoices
  attr_reader :prompt

  def initialize
    @prompt =  TTY::Prompt.new
  end
  
  def show(option)
    menu = menu_options
    prompt.select(menu_options[option].prompt, menu_options[option].options)
  end

  def menu_options
    OPTIONS.reduce({}) do |hash, option|
      hash[option] = get_menu_for(option)
      hash
    end
  end

  def get_menu_for(option)
    case option
    when FIGHT
      Menu.new(prompt:FIGHT_PROMPT , options: FIGHT_CHOICES)
    when FOUNTION
      Menu.new(prompt:FOUNTION_PROMPT, options: FOUNTION_CHOICES)
    end
  end
end