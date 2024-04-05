require 'rails_helper'

RSpec.describe Event, type: :model do

  it 'get all events in index' do
    Event.create(event_name: 'Birthday Party')
    Event.create(event_name: 'Party')
    Event.create(event_name: 'Dance')
    expect(Event.all).to eq(Event.all)
  end

  it 'event can be created' do
    event = Event.new
    event.event_name = 'Birthday Party'
    event.save
    expect(event.event_name).to eq('Birthday Party')
  end

  it 'event can be update' do
    event = Event.new
    event.event_name = 'Birthday Party'
    event.save

    event.update(event_name: 'Birthday Party 2')
    event.save
    expect(event.event_name).to eq('Birthday Party 2')
  end

  describe '#destroy' do
    it 'destroys the event' do
      event = Event.new(event_name: 'Birthday Party')
      event.save
      event.destroy
      expect(Event.exists?(event.id)).to eq(false)
    end
  end

  it 'should not save event without user id' do
    user = User.create(name: "sumit")
    event = Event.new
    event.event_name = "Birthday Party"
    event.save
    expect(event.save).to eq(false)
  end
end
