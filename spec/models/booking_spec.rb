require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe '#create' do
    it 'booking can be created' do
      booking = Booking.new
      booking.user_id = 1
      booking.event_id = 1
      booking.save
      expect(booking.user_id).to eq(1)
    end
  end

  describe '#index' do
    it 'get all bookings in index' do
      Booking.create(user_id: 1, event_id: 1)
      Booking.create(user_id: 1, event_id: 1)
      Booking.create(user_id: 1, event_id: 1)
      expect(Booking.all).to eq(Booking.all)
    end
  end

  describe '#update' do
    it 'booking can be updated' do
    booking = Booking.new
    booking.user_id = 1
    booking.event_id = 1
    booking.save

    booking.update(user_id: 2)
    booking.save
    expect(booking.user_id).to eq(2)
    end
  end

  describe '#destroy' do
    it 'booking can be destroyed' do
    booking = Booking.new
    booking.user_id = 1
    booking.event_id = 1
    booking.save
    booking.destroy
    expect(Booking.exists?(id: booking.id)).to eq(false)
    end
  end
end
