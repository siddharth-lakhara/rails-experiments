module Api
  module V1
    class ResourceController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        owner_id = params[:owner_id]
        user = User.find_by(id: owner_id)
        return render json: { errors: "user not found" }, status: :not_found if user.nil?

        permitted = params.permit(:description)
        if permitted[:description].nil? || permitted[:description].to_s.strip.empty?
          return render json: { error: "Missing required parameter(s): description" }, status: :bad_request
        end

        resource = Resource.new(owner_id: owner_id, description: permitted[:description])
        if resource.save
          render json: resource.slice(:id, :owner_id, :description), status: :created
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_content
        end
      end

      def findOne
        resource = Resource.find_by(id: params[:resource_id], owner_id: params[:owner_id])
        return render json: { errors: "not found" }, status: :not_found if resource.nil?
        render json: resource.slice(:id, :owner_id, :description), status: :ok
      end

      def findAll
        resources = Resource.where(owner_id: params[:owner_id]).select(:id, :description)
        render json: resources, status: :ok
      end

      def findOneResource
        resource = Resource.find_by(id: params[:resource_id])
        return render json: { errors: "not found" }, status: :not_found if resource.nil?
        render json: resource.slice(:id, :owner_id, :description), status: :ok
      end

      def update
        resource = Resource.find_by(id: params[:resource_id], owner_id: params[:owner_id])
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

      def deleteOne
        resource = Resource.find_by(id: params[:resource_id], owner_id: params[:owner_id])
        resource.destroy if resource
        head :ok
      end

      def deleteAll
        Resource.where(owner_id: params[:owner_id]).delete_all
        head :ok
      end
    end
  end
end
