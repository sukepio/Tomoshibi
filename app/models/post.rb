class Post < ApplicationRecord

  belongs_to :admin
  mount_uploaders :image, ImageUploader
  serialize :image, JSON

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 20 }

end
