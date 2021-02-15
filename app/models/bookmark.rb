class Bookmark < ApplicationRecord

  belongs_to :resident
  belongs_to :post

end
