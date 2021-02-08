class Household < ApplicationRecord

 has_many :residents

 validates :head_id, presence: true, uniqueness: true
 validates :address, presence: true, uniqueness: true
 validates :house_damage_situation, presence: true
 validates :living_space, presence: true

 def information
   head_id.to_s + " " + address
 end
end
