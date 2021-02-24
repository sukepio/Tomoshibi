class Photo < ApplicationRecord
  belongs_to :resident
  mount_uploaders :image, ResidentPhotoUploader
  serialize :image, JSON

  validates :resident_id, presence: true
  validates :image, presence: true
end
