class User < ApplicationRecord
  has_secure_password

  has_many :journal_entries, dependent: :destroy
  accepts_nested_attributes_for :journal_entries

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  def self.find_from_credentials(email, password)
    user = find_by(email: email)
    return nil unless user
    user if BCrypt::Password.new(user.password_digest).is_password?(password)
  end
end
