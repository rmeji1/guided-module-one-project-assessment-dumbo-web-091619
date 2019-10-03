class Monster < ActiveRecord::Base
    has_many :fights

    def self.get_monster_that_hasnt_fought(character)
        # Monster.find_by(name: "dragon")
        character.reload
        avail_monsters = self.all - character.monsters.to_a
        avail_monsters.sample
    end
end