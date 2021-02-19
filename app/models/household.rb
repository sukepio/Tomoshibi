class Household < ApplicationRecord

 has_many :residents

 validates :head_first_name, presence: true, uniqueness: true
 validates :head_last_name, presence: true, uniqueness: true
 validates :address, presence: true, uniqueness: true
 validates :house_damage_situation, presence: true
 validates :living_space, presence: true

 def information
   head_last_name + head_first_name + '　' + address
 end

 def full_name
  head_last_name + ' ' + head_first_name
 end

end
