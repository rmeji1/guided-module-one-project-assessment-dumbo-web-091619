require_relative "OptionModule"
class ChoiceInterface 
  include OptionModule::Options, OptionModule::FriendOrFoe,  OptionModule::FightChoices, OptionModule::RiverChoices
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
    when FRIEND_OR_FOE
      Menu.new(prompt:FRIEND_OR_FOE_PROMPT, options: FRIEND_OR_FOE_CHOICES)
    when RIVER
      Menu.new(prompt:RIVER_PROMPT, options: RIVER_CHOICES)
    end
  end
end