class Post < ApplicationRecord

  belongs_to :admin
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 20 }

end
