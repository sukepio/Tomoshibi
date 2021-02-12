class Post < ApplicationRecord

  belongs_to :admin
  mount_uploaders :image, ImageUploader
  serialize :image, JSON

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 20 }


  def time_format
    wd = ["日", "月", "火", "水", "木", "金", "土"]
    updated_at.strftime("%-m/%-d(#{wd[updated_at.wday]})")
  end

end
