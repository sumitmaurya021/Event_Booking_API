class Api::V1::TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update, :destroy]

  def index
    @tickets = Ticket.all
    render json: @tickets
  end

  def show
    render json: @ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      render json: { ticket: @ticket, message: "Ticket created successfully" }, status: :created
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
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
      render json: { message: "Ticket deleted successfully" }, status: :ok
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:event_id, :ticket_number, :price)
  end
end
