class Speaker < ApplicationRecord
  has_and_belongs_to_many :events

  validates :name, presence: true, uniqueness: true
  validates :bio, presence: true, length: { maximum: 500 }
  validates :phone, presence: true, length: { maximum: 10 }
  validates :email, presence: true
end
