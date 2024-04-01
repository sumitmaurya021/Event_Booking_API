class BookingMailer < ApplicationMailer
  def booking_confirmation(user, event, booking)
    @user = user
    @event = event
    @booking = booking
    mail(to: @user.email, subject: 'Event Booking Confirmation')
  end

  def event_update_notification(user, event, current_user)
    @user = user
    @event = event
    @current_user = current_user
    mail(to: @user.email, subject: 'Event Update Notification')
  end
end
