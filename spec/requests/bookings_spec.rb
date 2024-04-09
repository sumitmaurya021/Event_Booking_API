require 'rails_helper'

RSpec.describe "Bookings", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:application) { FactoryBot.create(:oauth_application) }
  let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: user.id, application_id: application.id) }

  before do
    sign_in(user, scope: :user)
  end

  describe "GET /bookings" do
    it "returns a list of bookings with status code 200" do
      get api_v1_bookings_path, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /bookings/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:booking) { FactoryBot.create(:booking, user: user, event: event) }

    it "returns a single booking with status code 200" do
      get api_v1_booking_path(booking), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /bookings/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:booking) { FactoryBot.create(:booking, user: user, event: event) }

    it "updates a booking with status code 200" do
      updated_booking_params = FactoryBot.attributes_for(:booking, user: user, event: event)
      put api_v1_booking_path(booking), params: { booking: updated_booking_params }, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /bookings/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:booking) { FactoryBot.create(:booking, user: user, event: event) }
    it "deletes an booking with status code 200" do
      delete api_v1_booking_path(booking), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end
end



