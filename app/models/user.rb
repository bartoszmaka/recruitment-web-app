class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :interests, dependent: :destroy

  enum gender: %i[male female]

  validates :age, presence: true,
                  inclusion: 0..100
  validates :gender, presence: true

  accepts_nested_attributes_for :interests, reject_if: :all_blank, allow_destroy: true
end
