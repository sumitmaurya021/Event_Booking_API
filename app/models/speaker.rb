class Speaker < ApplicationRecord
  has_and_belongs_to_many :events

  validates :name, presence: true
  validates :bio, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :event_id, presence: true
end
