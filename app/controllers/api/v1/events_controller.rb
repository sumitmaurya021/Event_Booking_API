class Api::V1::EventsController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:index, :show]
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :check_user, except: [:show, :index, :create, :update, :destroy, :upcoming_events]

  def index
    if current_user && current_user.account_status == "active"
      @events = Event.all
      render json: { events: @events, message: "This is the list of all the events" }, status: :ok
    else
      render json: { error: 'Unauthorized', message: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end

  def show
    render json: { event: @event, message: "This is the event with id: #{params[:id]}" }, status: :ok
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      generate_tickets_for_event(@event)
      render json: { event: @event, message: "Event created successfully" }, status: :created
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render json: { event: @event, message: "Event updated successfully" }, status: :ok
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      render json: { message: "Event deleted successfully" }, status: :ok
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def upcoming_events
    @events = Event.where("date >= ?", Date.today).order(date: :asc)
    render json: { events: @events }, status: :ok
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:event_name, :agenda, :description, :date, :time, :location, :total_tickets, :ticket_price, :total_seats, :user_id)
  end

  def check_user
    unless current_user && (current_user.admin? || (current_user.organizer? && current_user.account_status == "active"))
      render json: { error: 'Unauthorized', message: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end

  def generate_tickets_for_event(event)
    event.total_tickets.times do
      ticket_number = generate_ticket_number
      ticket_price = event.ticket_price
      event.tickets.create(ticket_number: ticket_number, price: ticket_price)
    end
  end

  def generate_ticket_number
    loop do
      ticket_number = SecureRandom.hex(4).upcase
      break ticket_number unless Ticket.exists?(ticket_number: ticket_number)
    end
  end
end
