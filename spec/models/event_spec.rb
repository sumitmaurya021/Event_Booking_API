require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { Event.new(event_name: 'Birthday Party', agenda: 'Birthday Party', description: 'Birthday Party', date: Date.today, time: Time.now, location: 'New Delhi', total_tickets: 100, ticket_price: 1000, total_seats: 100) }

  describe 'validations' do

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is valid with event name' do
      subject.event_name = 'Birthday Party'
      expect(subject).to be_valid
    end

    it 'is valid with agenda' do
      subject.agenda = 'Birthday Party'
      expect(subject).to be_valid
    end

    it 'is valid with description' do
      subject.description = 'Birthday Party'
      expect(subject).to be_valid
    end

    it 'is valid with date' do
      subject.date = Date.today
      expect(subject).to be_valid
    end

    it 'is valid with time' do
      subject.time = Time.now
      expect(subject).to be_valid
    end

    it 'is valid with location' do
      subject.location = 'New Delhi'
      expect(subject).to be_valid
    end

    it 'is valid with total_tickets' do
      subject.total_tickets = 100
      expect(subject).to be_valid
    end

    it 'is valid with ticket_price' do
      subject.ticket_price = 1000
      expect(subject).to be_valid
    end

    it 'is valid with total_seats' do
      subject.total_seats = 100
      expect(subject).to be_valid
    end
  end

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
    expect(event.save).to eq(false)
  end

end
