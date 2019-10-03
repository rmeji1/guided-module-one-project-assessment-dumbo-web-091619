User.destroy_all
Character.destroy_all
Monster.destroy_all
Result.destroy_all
Choice.destroy_all
Fight.destroy_all

user1 = User.create(username:"User1", wins: 0, losses: 0)
user2 = User.create(username:"User2", wins: 0, losses: 0)
user3 = User.create(username:"User3", wins: 0, losses: 0)
user4 = User.create(username:"User4", wins: 0, losses: 0)
user5 = User.create(username:"User5", wins: 0, losses: 0)
user6 = User.create(username:"User6", wins: 0, losses: 0)

character1 = Character.create(name:"Character1",user:user1,max_health:100, class_type: "Mage", strength: 5, current_health: 100)
character2 = Character.create(name:"Character2",user:user2,max_health:15, class_type: "Warrior", strength: 7, current_health: 15)
character3 = Character.create(name:"Character3",user:user3,max_health:30, class_type: "Mage", strength: 10, current_health: 30)
character4 = Character.create(name:"Character4",user:user4,max_health:45, class_type: "Warrior", strength: 8, current_health: 45)
character5 = Character.create(name:"Character5",user:user5,max_health:60, class_type: "Mage", strength: 3, current_health: 60)
character6 = Character.create(name:"Character6",user:user6,max_health:10, class_type: "Warrior", strength: 4, current_health: 10)

Monster.create(name: "ogre", health:20, fight_damage: 10, run_damage:5)
Monster.create(name: "dragon", health:30, fight_damage: 15, run_damage:10)
Monster.create(name: "wolf", health:10, fight_damage: 5, run_damage:3)
Monster.create(name: "ghoul", health:15, fight_damage: 8, run_damage:4)
Monster.create(name: "demon", health:25, fight_damage: 18, run_damage:13)
Monster.create(name: "bear", health:15, fight_damage: 8, run_damage:3)

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