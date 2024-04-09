class ApplicationController < ActionController::Base
    # skip_before_action :verify_authenticity_token
    before_action :doorkeeper_authorize!

    private

    def current_user
      if doorkeeper_token
        return current_resource_owner
      end
      warden.authenticate(scope: :user)
    end

    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id)  if doorkeeper_token
    end
end
