class Interest < ApplicationRecord
  has_many :user_interests, dependent: :destroy
  has_many :users, through: :user_interests

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

  before_save { name.downcase! }
end
