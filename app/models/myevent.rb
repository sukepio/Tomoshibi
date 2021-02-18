class Myevent < ApplicationRecord

  belongs_to :resident

  validates :title, presence: true
end
