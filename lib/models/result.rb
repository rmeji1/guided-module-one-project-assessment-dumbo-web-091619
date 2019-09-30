class Result < ActiveRecord::Base
    has_many :choices
    has_many :characters, through: :choices
    has_many :fights, through: :choices
end