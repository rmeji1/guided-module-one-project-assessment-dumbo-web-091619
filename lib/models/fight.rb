class Fight < ActiveRecord::Base
    belongs_to :monster
    belongs_to :choice
    has_one :character, through: :choice

end