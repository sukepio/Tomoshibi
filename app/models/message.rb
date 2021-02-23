class Message < ApplicationRecord
  validates :sender, presence: true
  mount_uploader :image, MessageUploader
end
