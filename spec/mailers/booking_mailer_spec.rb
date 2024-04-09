require "rails_helper"

RSpec.describe BookingMailer, type: :mailer do

  describe '#booking_confirmation' do
    let(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:booking) { FactoryBot.create(:booking, user: user, event: event) }

    it 'send booking confirmation email to user' do
      email = BookingMailer.booking_confirmation(user, event, booking).deliver_now

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(email.to).to eq([user.email])
      expect(email.subject).to eq('Event Booking Confirmation')

    end
  end

  describe '#event_update_notification' do
    let(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:current_user) { FactoryBot.create(:user) }

  it 'sends an event update notification email' do
    email = BookingMailer.event_update_notification(user, event, current_user).deliver_now

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(email.to).to eq([user.email])
    expect(email.subject).to eq('Event Update Notification')
  end
end
end
