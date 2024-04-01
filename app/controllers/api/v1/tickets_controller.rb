class Api::V1::TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update, :destroy]

  def index
    @tickets = current_user.tickets
    render json: { tickets: @tickets, message: "This is the list of all the tickets" }, status: :ok
  end

  def show
    render json: { ticket: @ticket, message: "This is the details of the ticket" }, status: :ok
  end

  def update
    if @ticket.update(ticket_params)
      render json: { ticket: @ticket, message: "Ticket updated successfully" }, status: :ok
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @ticket.destroy
      render json: { message: "Ticket with id: #{@ticket.id} deleted successfully" }, status: :ok
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_ticket
    @ticket = current_user.tickets.find_by(id: params[:id])
    render json: { error: "Ticket not found" }, status: :not_found unless @ticket
  end
  def ticket_params
    params.require(:ticket).permit(:event_id, :ticket_number, :price, :booking_id)
  end
end
