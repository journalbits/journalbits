module Api
  module V1
    class UsersController < BaseController
      doorkeeper_for :all
      respond_to :json

      def index
        respond_with user.days
      end

    end
  end
end