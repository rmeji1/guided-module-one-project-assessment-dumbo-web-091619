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
    play_environment_sound_for(option)
    prompt.select(menu_options[option].prompt, menu_options[option].options)
  end

  def menu_options
    OPTIONS.reduce({}) do |hash, option|
      hash[option] = get_menu_for(option)
      hash
    end
  end

  def play_environment_sound_for(option)
    if option == "cave"
      GameRunner.play("cave.mov") 
    elsif option == RIVER
      GameRunner.play("river.mov") 
    elsif option == FRIEND_OR_FOE
      GameRunner.play("stranger.mov")
    end
  end
  
  def get_menu_for(option)
    if option == FIGHT
      get_monster_menu()
    elsif option == FRIEND_OR_FOE
      Menu.new(prompt: STRANGER_IMAGE + "\n\n" + FRIEND_OR_FOE_PROMPT, options: FRIEND_OR_FOE_CHOICES)
    elsif option == RIVER
      Menu.new(prompt: RIVER_IMAGE + "\n\n" + RIVER_PROMPT, options: RIVER_CHOICES)
    elsif option == "cave"
      Menu.new(prompt: CAVE_IMAGE + "\n\n" + CAVE_PROMPT, options: CAVE_CHOICES)
    end
  end

  def get_monster_menu
    name = "monster"
    art = ""
    if @choice.monster != nil 
      name = @choice.monster.name
      art = get_image_for(name) + "\n\n"
    end
    prompt = "#{art}Oh no! You see a #{name} in front of you. Do you fight or run away?" 
    Menu.new(prompt: prompt , options: FIGHT_CHOICES)
  end

  def get_image_for(name)
    if name == "ogre"
      GameRunner.play("ogre.m4a")
      return OGRE_IMAGE
    elsif name == "ghoul"
      GameRunner.play("ghoul.mov")
      return GHOUL_IMAGE
    elsif name == "dragon"
      GameRunner.play("dragon.mov")
      return DRAGON_IMAGE
    elsif name == "wolf"
      GameRunner.play("wolf.mp3")
      return WOLF_IMAGE
    elsif name == "demon"
      GameRunner.play("demon.mov")
      return DEMON_IMAGE
    elsif name == "bear"
      GameRunner.play("bear.mov")
      return BEAR_IMAGE
    end

    return ""
  end
end