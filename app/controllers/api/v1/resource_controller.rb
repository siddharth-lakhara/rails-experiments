module Api
  module V1
    class ResourceController < ApplicationController
      include Authentication
      protect_from_forgery with: :null_session
      before_action :authenticate_user!

      def create
        permitted = params.permit(:description)
        if permitted[:description].nil? || permitted[:description].to_s.strip.empty?
          return render json: { error: "Missing required parameter(s): description" }, status: :bad_request
        end

        resource = Resource.new(owner_id: current_user.id, description: permitted[:description])
        if resource.save
          render json: resource.slice(:id, :owner_id, :description), status: :created
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_content
        end
      end

      def find_one
        resource = Resource.find_by(id: params[:resource_id], owner_id: current_user.id)
        return render json: { errors: "not found" }, status: :not_found if resource.nil?
        render json: resource.slice(:id, :owner_id, :description), status: :ok
      end

      def find_all
        resources = Resource.where(owner_id: current_user.id).select(:id, :description)
        render json: resources, status: :ok
      end

      def update
        resource = Resource.find_by(id: params[:resource_id], owner_id: current_user.id)
        return render json: { errors: "not found" }, status: :not_found if resource.nil?

        permitted = params.permit(:description)
        if permitted[:description].nil? || permitted[:description].to_s.strip.empty?
          return render json: { error: "Missing required parameter(s): description" }, status: :bad_request
        end

        if resource.update(description: permitted[:description])
          render json: resource.slice(:id, :owner_id, :description), status: :ok
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_content
        end
      end

      def delete
        resource = Resource.find_by(id: params[:resource_id], owner_id: current_user.id)
        resource.destroy if resource
        head :ok
      end

      def delete_all
        Resource.where(owner_id: current_user.id).delete_all
        head :ok
      end
    end
  end
end
