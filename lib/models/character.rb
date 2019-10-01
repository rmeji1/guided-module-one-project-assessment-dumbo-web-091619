class Character < ActiveRecord::Base
    belongs_to :user
    has_many :choices
    has_many :results, through: :choices
    has_many :fights, through: :choices
    has_many :monsters, through: :fights
end