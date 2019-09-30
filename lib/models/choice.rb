class Choice < ActiveRecord::Base
    has_many :fights
    belongs_to :character
    belongs_to :result
    has_many :monsters, through: :fights
end