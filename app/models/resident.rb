class Resident < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :phone_number, presence: true
  validates :login_id, presence: true
  validates :date_of_birth, presence: true
  validates :gender, presence: true
  validates :self_message, length: { maximum: 25}

  belongs_to :household, optional: true
  has_many :photos, dependent: :destroy
  has_many :myevents, dependent: :destroy
  has_many :bookmarks, dependent: :destroy


  enum gender: { 男: 0, 女: 1}

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def full_name
    last_name + " " + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

  def date_format
    '%Y/%-m/%-d'
  end

  def birthday
    date_of_birth.strftime(date_format)
  end

  def age
    (Date.today.strftime(date_format).to_i - birthday.to_i)
  end
end
