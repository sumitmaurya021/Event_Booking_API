class Ticket < ApplicationRecord
  belongs_to :event

  validates :price, presence: true
  validates :ticket_number, presence: true
end
