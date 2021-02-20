class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :phone_number, presence: true
  validates :login_id, presence: true
  validates :date_of_birth, presence: true

  def full_name
    last_name + first_name
  end

  # ゲストログインメソッド
  def self.guest
    find_or_create_by!(first_name: '太郎', last_name: '管理', first_name_kana: 'タロウ', last_name_kana: 'カンリ', email: 'guest@admin.com', phone_number: '00011112222', date_of_birth: '2000-01-01', login_id: 'guest.login') do |admin|
      admin.password = SecureRandom.urlsafe_base64
    end
  end
end
