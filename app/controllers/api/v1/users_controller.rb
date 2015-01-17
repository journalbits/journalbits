module Api
  module V1
    class UsersController < BaseController
      before_action :doorkeeper_authorize!
      respond_to :json

      def index
        respond_with user.days
      end

    end
  end
end