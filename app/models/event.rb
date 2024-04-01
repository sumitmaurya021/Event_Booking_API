class Event < ApplicationRecord
  has_many :users, through: :event
  has_and_belongs_to_many :speakers
  has_many :tickets
  has_many :bookings, dependent: :destroy


  validates :event_name, presence: true
  validates :agenda, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location, presence: true
  validates :total_tickets, presence: true
  validates :ticket_price, presence: true
  validates :total_seats, presence: true
end
