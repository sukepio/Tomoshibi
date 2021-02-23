class Myevent < ApplicationRecord
  belongs_to :resident

  validates :title, presence: true
  validates :resident_id, presence: true
end
