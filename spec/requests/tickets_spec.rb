require 'rails_helper'

RSpec.describe "Tickets", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:application) { FactoryBot.create(:oauth_application) }
  let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: user.id, application_id: application.id) }

  before do
    sign_in(user, scope: :user)
  end

  describe "GET /tickets" do
    it "returns a list of tickets with status code 200" do
      get api_v1_tickets_path, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /tickets/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:booking) { FactoryBot.create(:booking, user: user, event: event) }
    let(:ticket) { FactoryBot.create(:ticket, user: user, event: event, booking: booking) }

    it "returns a single ticket with status code 200" do
      get api_v1_ticket_path(ticket), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /tickets/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:booking) { FactoryBot.create(:booking, user: user, event: event) }
    let(:ticket) { FactoryBot.create(:ticket, user: user, event: event, booking: booking) }
    it "updates a ticket with status code 200" do
      updated_ticket_params = FactoryBot.attributes_for(:ticket, user: user, event: event, booking: booking)
      put api_v1_ticket_path(ticket), params: { ticket: updated_ticket_params }, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /tickets/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:booking) { FactoryBot.create(:booking, user: user, event: event) }
    let(:ticket) { FactoryBot.create(:ticket, user: user, event: event, booking: booking) }
    it "deletes a ticket with status code 200" do
      delete api_v1_ticket_path(ticket), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

end
