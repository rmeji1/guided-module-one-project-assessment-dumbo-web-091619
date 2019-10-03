class Monster < ActiveRecord::Base
    has_many :fights

    def self.get_monster_that_hasnt_fought(character)
        character.reload
        avail_monsters = self.all - character.monsters.to_a
        if avail_monsters == [] 
            avail_monsters = self.all
        end
        avail_monsters.sample
    end
end