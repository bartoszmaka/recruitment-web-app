class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :interests, dependent: :destroy

  enum gender: %i[male female]
end
