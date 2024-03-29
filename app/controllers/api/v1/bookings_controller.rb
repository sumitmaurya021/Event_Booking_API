class Api::V1::BookingsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_booking, only: [:show, :update, :destroy]

  def index
    @bookings = current_user.bookings
    render json: { bookings: @bookings, message: "This is the list of all the bookings" }, status: :ok
  end

  def show
    @booking = current_user.bookings.find_by(id: params[:id])
    render json: { booking: @booking, message: "This is the booking with id: #{params[:id]}" }, status: :ok
  end

  def create
    @event = Event.find_by(id: booking_params[:event_id])
    if @event
      ticket_number = booking_params[:ticket_number].to_i
      price = @event.ticket_price
      if @event.total_tickets >= ticket_number
        @booking = current_user.bookings.new(event_id: @event.id)
        if @booking.save
          booking_done = generate_tickets_for_booking(@booking, ticket_number, price, current_user.id)
          if booking_done.nil?
            BookingMailer.booking_confirmation(current_user, @event, @booking).deliver_now
            render json: { booking: @booking, message: "Booking successfully" }, status: :created
          else
            render json: { error: booking_done }, status: :unprocessable_entity
          end
        else
          render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: "Not enough tickets available for booking" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Event not found" }, status: :not_found
    end
  end


  def update
    if @booking
      if @booking.update(booking_params)
        render json: { booking: @booking, message: "Booking updated successfully" }, status: :ok
      else
        render json: { error: @booking.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Booking not found" }, status: :not_found
    end
  end

  def destroy
    if @booking
      if @booking.destroy
        render json: { message: "Booking deleted successfully" }, status: :ok
      else
        render json: { error: @booking.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Booking not found" }, status: :not_found
    end
  end

  private

  def set_booking
    @booking = current_user.bookings.find_by(id: params[:id])
  end

  def booking_params
    params.require(:booking).permit(:event_id, :ticket_number)
  end

  def generate_tickets_for_booking(booking, ticket_count, price, user_id)
    event = Event.find(booking.event_id)
    ticket_count.times do
      ticket_number = generate_ticket_number
      ticket = Ticket.create(ticket_number: ticket_number, event_id: event.id, booking_id: booking.id, user_id: user_id, price: price) # Assign user_id
      unless ticket.valid?
        return "Failed to create ticket: #{ticket.errors.full_messages.join(', ')}"
      end
    end
    event.decrement!(:total_tickets, ticket_count)
    return nil
  end

  def generate_ticket_number
    loop do
      ticket_number = SecureRandom.hex(4).upcase
      break ticket_number unless Ticket.exists?(ticket_number: ticket_number)
    end
  end
end
