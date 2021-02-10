class Photo < ApplicationRecord

  belongs_to :resident
  mount_uploaders :images, ResidentPhotoUploader
  serialize :images, JSON


  validates :resident_id, presence: true
end
