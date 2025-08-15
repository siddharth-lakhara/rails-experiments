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

      # First draft created via AI
      # (Kilo Code + GPT 5 OSS) = (0.12 + 0.04 +0.07) = 0.23 USD
      def create
        permitted = params.permit(:email, :name)

        # Require the email key to be present; name is optional
        unless permitted.key?(:email)
          return render json: { error: "Missing required parameter(s): email" }, status: :bad_request
        end

        # If name key is not present, default it to empty string
        unless permitted.key?(:name)
          permitted[:name] = ""
        end

        if User.exists?(permitted[:email])
          return render json: { error: "user already exists" }, status: :conflict
        end

        user = User.new(permitted)
        if user.save
          render json: { id: user.id, email: user.email, name: user.name }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_content
        end
      end
    end
  end
end
