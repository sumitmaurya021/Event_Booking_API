class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :tickets, dependent: :destroy

  validates :user_id, presence: true
  validates :event_id, presence: true
end
