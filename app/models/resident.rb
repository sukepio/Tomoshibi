class Resident < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :household, optional: true
  has_many :photos, dependent: :destroy
  has_many :myevents, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :phone_number, presence: true
  validates :login_id, presence: true
  validates :date_of_birth, presence: true
  validates :gender, presence: true
  validates :self_message, length: { maximum: 20 }

  enum gender: { man: 0, woman: 1 }

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  # ゲストログインメソッド
  def self.guest
    find_or_create_by!(first_name: '太郎', last_name: 'ゲスト', first_name_kana: 'タロウ', last_name_kana: 'ゲスト', phone_number: '00011112222', date_of_birth: '2000-01-01', login_id: 'guest.login') do |resident|
      resident.password = SecureRandom.urlsafe_base64
    end
  end
end
