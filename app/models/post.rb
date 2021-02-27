class Post < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  belongs_to :admin
  mount_uploaders :image, ImageUploader
  serialize :image, JSON

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 20 }
  validates :admin_id, presence: true

  def bookmarked_by?(resident)
    bookmarks.where(resident_id: resident.id).exists?
  end
end
