module Api
  module V1
    class UsersController < ApplicationController
      protect_from_forgery with: :null_session

      def findOne
        user = User.find_by(id: params[:user_id])
        if user.nil?
          return render json: { errors: "not found"}, status: :not_found
        end
        render json: user.slice(:id, :name, :email), status: :ok
      end

      def deleteUser
        user = User.find_by(id: params[:user_id])
        user.destroy if user
        head :ok
      end

      def updateUser
        user = User.find_by(id: params[:user_id])
        return render json: { errors: "not found" }, status: :not_found if user.nil?

        permitted = params.permit(:name, :email)
        update_payload = permitted.slice(:name, :email)
        begin
          if user.update(update_payload)
            render json: user.slice(:id, :name, :email), status: :ok
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_content
          end
        rescue ActiveRecord::RecordNotUnique => err
          render json: { errors: "email already taken" }, status: :unprocessable_content
        rescue StandardError => err
          render json: { errors: "something went wrong" }, status: :unprocessable_content
        end
      end

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
