class Interest < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :interest_type, presence: true

  enum interest_type: %i[health hobby work]
end
