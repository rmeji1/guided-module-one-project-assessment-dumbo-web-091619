require_relative '../config/environment'
User.delete_all
Character.delete_all
Monster.delete_all
Result.delete_all
Choice.delete_all
Fight.delete_all

user1 = User.create(username:"User1")

character1 = Character.create(name:"Character1",user:user1,health:20, class_type: "Mage", strength: 5, alive: true)


monster1 = Monster.create(name: "Monster1", health:10, fight_damage: 20, run_damage:15)
monster2 = Monster.create(name: "Monster2", health:10, fight_damage: 20, run_damage:15)
monster3 = Monster.create(name: "Monster3", health:10, fight_damage: 20, run_damage:15)
monster4 = Monster.create(name: "Monster4", health:10, fight_damage: 20, run_damage:15)
monster5 = Monster.create(name: "Monster5", health:10, fight_damage: 20, run_damage:15)
monster6 = Monster.create(name: "Monster6", health:10, fight_damage: 20, run_damage:15)

NORTH = "North"
EAST = "East"
SOUTH = "South"
WEST = "West"

@prompt = TTY::Prompt.new
@prompt.say("Hey you will have to make a choice", color: :bright_cyan)

start = @prompt.select("You're standing in the middle of a dense forest. There are four paths: one going north, one going east, one going south, and one going west. Which path do you take?") do |prompt|
  prompt.choice NORTH
  prompt.choice EAST
  prompt.choice SOUTH
  prompt.choice WEST
end

case start
when NORTH
  choice = Choice.create(character: character1)
  # choice.fight = Fight.create(monster: Monster.create(name: "Monster1", health:10, fight_damage: 20, run_damage:15))
  choice.show_menu
  result = Result.create(choice: choice)
  result.outcome
else
  puts "Bye bye"
end

# binding.pry
# puts "hello world"
