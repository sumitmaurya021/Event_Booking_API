class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :booking
  belongs_to :user

  validates :price, presence: true
  validates :ticket_number, presence: true
end
