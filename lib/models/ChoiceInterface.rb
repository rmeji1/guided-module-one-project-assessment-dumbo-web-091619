require_relative "OptionModule"
require_relative "ArtModule"

class ChoiceInterface 
  include OptionModule::Options, OptionModule::FriendOrFoe,  OptionModule::FightChoices, OptionModule::RiverChoices, OptionModule::CaveChoices, ArtModule
  attr_reader :prompt, :choice

  def initialize(choice)
    @prompt =  TTY::Prompt.new
    @choice = choice
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
      name = "monster"
      art = ""
      if @choice.monster != nil 
        name = @choice.monster.name
        art = get_image_for(name) + "\n\n"
      end
      prompt = "#{art}Oh no! You see a #{name} in front of you. Do you fight or run away?" 
      Menu.new(prompt: prompt , options: FIGHT_CHOICES)
    when FRIEND_OR_FOE
      Menu.new(prompt: STRANGER_IMAGE + "\n\n" + FRIEND_OR_FOE_PROMPT, options: FRIEND_OR_FOE_CHOICES)
    when RIVER
      Menu.new(prompt: RIVER_IMAGE + "\n\n" + RIVER_PROMPT, options: RIVER_CHOICES)
    when CAVE
      Menu.new(prompt: CAVE_IMAGE + "\n\n" + CAVE_PROMPT, options: CAVE_CHOICES)
    end
  end


  def get_image_for(name)
    if name == "ogre"
      return OGRE_IMAGE
    elsif name == "ghoul"
      return GHOUL_IMAGE
    elsif name == "dragon"
      GameRunner.play_dragon_noise
      sleep 0.15
      return DRAGON_IMAGE
    elsif name == "wolf"
      GameRunner.play_wolf_noise
      sleep 0.25
      return WOLF_IMAGE
    elsif name == "demon"
      GameRunner.play_demon_noise
      sleep 0.25
      return DEMON_IMAGE
    elsif name == "bear"
      GameRunner.play_bear_noise
      sleep 0.15
      return BEAR_IMAGE
    end

    return ""
  end


end