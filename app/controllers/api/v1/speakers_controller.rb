class Api::V1::SpeakersController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:index, :show]
  before_action :set_speaker, only: [:show, :update, :destroy]

  def index
    if current_user && current_user.account_status == "active"
      @speakers = Speaker.all
      render json: { speakers: @speakers, message: "This is the list of all the speakers" }, status: :ok
    else
      render json: { error: 'Unauthorized', message: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end

  def show
    render json: { speaker: @speaker, message: "This is the speaker with id: #{params[:id]}" }, status: :ok
  end

  def create
    if current_user.admin? || current_user.organizer?
      @speaker = Speaker.new(speaker_params)
      if @speaker.save
        event = Event.find(params[:speaker][:event_id])
        event.speakers << @speaker
        render json: { speaker: @speaker, message: "Speaker created successfully" }, status: :created
      else
        render json: { errors: @speaker.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized', message: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end

  def update
    if @speaker.update(speaker_params)
      render json: { speaker: @speaker, message: "Speaker updated successfully" }, status: :ok
    else
      render json: { errors: @speaker.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @speaker.destroy
      render json: { message: "Speaker deleted successfully" }, status: :ok
    else
      render json: { errors: @speaker.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_speaker
    @speaker = current_user.speakers.find_by(id: params[:id])
  end

  def speaker_params
    params.require(:speaker).permit(:name, :bio, :phone, :email, :speaker_id)
  end
end
