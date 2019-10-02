User.destroy_all
Character.destroy_all
Monster.destroy_all
Result.destroy_all
Choice.destroy_all
Fight.destroy_all

user1 = User.create(username:"User1")
user2 = User.create(username:"User2")
user3 = User.create(username:"User3")
user4 = User.create(username:"User4")
user5 = User.create(username:"User5")
user6 = User.create(username:"User6")

character1 = Character.create(name:"Character1",user:user1,health:100, class_type: "Mage", strength: 5, alive: true)
character2 = Character.create(name:"Character2",user:user2,health:15, class_type: "Warrior", strength: 7, alive: true)
character3 = Character.create(name:"Character3",user:user3,health:30, class_type: "Mage", strength: 10, alive: true)
character4 = Character.create(name:"Character4",user:user4,health:45, class_type: "Warrior", strength: 8, alive: true)
character5 = Character.create(name:"Character5",user:user5,health:60, class_type: "Mage", strength: 3, alive: true)
character6 = Character.create(name:"Character6",user:user6,health:10, class_type: "Warrior", strength: 4, alive: true)

Monster.create(name: "ogre", health:20, fight_damage: 15, run_damage:20)
Monster.create(name: "dragon", health:30, fight_damage: 25, run_damage:20)
Monster.create(name: "wolf", health:10, fight_damage: 5, run_damage:3)
Monster.create(name: "ghoul", health:15, fight_damage: 10, run_damage:5)
Monster.create(name: "demon", health:25, fight_damage: 20, run_damage:15)
Monster.create(name: "bear", health:15, fight_damage: 10, run_damage:5)

# result1 = Result.create(did_win?: false)
# result2 = Result.create(did_win?: true)
# result3 = Result.create(did_win?: false)
# result4 = Result.create(did_win?: true)
# result5 = Result.create(did_win?: false)
# result6 = Result.create(did_win?: true)


# choice1 = Choice.create(character: character1, result:result1)
# choice2 = Choice.create(character: character2, result:result2)
# choice3 = Choice.create(character: character3, result:result3)
# choice4 = Choice.create(character: character4, result:result4)
# choice5 = Choice.create(character: character5, result:result5)
# choice6 = Choice.create(character: character6, result:result6)

# fight1 = Fight.create(location:"WeWork Dumbo", monster: monster1, choice: choice1, fight: true)
# fight2 = Fight.create(location:"WeWork Flatiron", monster: monster2, choice: choice2, fight: true)
# fight3 = Fight.create(location:"test3", monster: monster3, choice: choice3, fight: false)
# fight4 = Fight.create(location:"test4", monster: monster4, choice: choice4, fight: false)
# fight5 = Fight.create(location:"test5", monster: monster5, choice: choice5, fight: true)
# fight6 = Fight.create(location:"test6", monster: monster6, choice: choice6, fight: true)

puts "It's been seeded."