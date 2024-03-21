class Event < ApplicationRecord
  belongs_to :user
  has_many :speakers


  validates :event_name, presence: true
  validates :agenda, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location, presence: true
  validates :total_tickets, presence: true
  validates :ticket_price, presence: true
  validates :total_seats, presence: true
  validates :user_id, presence: true
end
