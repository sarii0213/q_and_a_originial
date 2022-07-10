class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  has_many :questions

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end