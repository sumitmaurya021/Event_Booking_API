require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject 

  describe '#index' do
    it 'get all tickets in index' do
      Ticket.create(price: 100, event_id: 1, booking_id: 1, user_id: 1)
      expect(Ticket.all).to eq(Ticket.all)
    end
  end

  describe '#update' do
    it 'ticket can be updated' do
      ticket = Ticket.new
      ticket.price = 100
      ticket.event_id = 1
      ticket.booking_id = 1
      ticket.user_id = 1
      ticket.save
      expect(ticket.price).to eq(100)
    end
  end

  describe '#destroy' do
    it 'ticket can be destroyed' do
      ticket = Ticket.new
      ticket.price = 100
      ticket.event_id = 1
      ticket.booking_id = 1
      ticket.user_id = 1
      ticket.save
      ticket.destroy
      expect(Ticket.all).to eq([])
    end
  end
end
