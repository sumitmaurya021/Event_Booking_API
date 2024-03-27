class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :booking

  validates :price, presence: true
  validates :ticket_number, presence: true
end
