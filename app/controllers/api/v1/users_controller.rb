module Api
  module V1
    class UsersController < ApplicationController
      protect_from_forgery with: :null_session

      def findOne
        # Implement lookup logic
        head :ok
      end

      def findAll
        # Implement list logic
        head :ok
      end

      def create
        params.inspect
        render json: {}, status: :created
      end
    end
  end
end
