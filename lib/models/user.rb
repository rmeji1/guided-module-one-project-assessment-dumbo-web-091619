class User < ActiveRecord::Base
    has_many :characters
    has_many :choices, through: :characters
end