class Post < ApplicationRecord

  belongs_to :admin
  
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 20 } 
  
end
