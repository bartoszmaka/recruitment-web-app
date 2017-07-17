class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :interests, dependent: :destroy

  enum gender: %i[male female]

  accepts_nested_attributes_for :interests, reject_if: :all_blank, allow_destroy: true
end
