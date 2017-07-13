class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :user_interests, dependent: :destroy
  has_many :interests, through: :user_interests

  enum gender: %i[male female]
end
