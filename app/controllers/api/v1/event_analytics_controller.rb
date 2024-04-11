class Api::V1::EventAnalyticsController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: [:download_pdf]
  def download_pdf
    @event = Event.find(params[:event_id])
    unless @event
      render json: { error: "Event not found" }, status: :not_found
      return
    end
    @speaker = @event.speakers
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "event_analytics",
        template: "event_pdf",
        page_size: "A4",
        locals: {
          event: @event
         }
      end
    end
  end
end
