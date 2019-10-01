class User < ActiveRecord::Base
    has_many :characters
    has_many :choices, through: :characters
    has_many :fights, through: :choices
    has_many :monsters, through: :fights
end