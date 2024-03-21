class Api::V1::SpeakersController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:index, :show]

  def create
    @speaker = Speaker.new(speaker_params)

    if @speaker.save
      render json: { speaker: @speaker, message: "Speaker created successfully" }, status: :created
    else
      render json: { errors: @speaker.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def index
    if current_user && current_user.account_status == "active"
    @speakers = Speaker.all
    render json: { speakers: @speakers, message: "This is the list of all the speakers" }, status: :ok
    else
      render json: { error: 'Unauthorized', message: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end

  def show
    @speaker = Speaker.find(params[:id])
    render json: { speaker: @speaker, message: "This is the speaker with id: #{params[:id]}" }, status: :ok
  end

  def destroy
    if @speaker.destroy
      render json: { message: "Speaker deleted successfully" }, status: :ok
    else
      render json: { errors: @speaker.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def speaker_params
    params.require(:speaker).permit(:name, :bio, :phone, :email, :event_id)
  end
end
