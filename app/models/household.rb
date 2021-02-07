class Household < ApplicationRecord

 has_many :residents

 validates :address, presence: true, uniqueness: true
 validates :house_damage_situation, presence: true
 validates :living_space, presence: true
end
