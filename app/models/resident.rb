class Resident < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :household, optional: true
  has_many :photos, dependent: :destroy

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
