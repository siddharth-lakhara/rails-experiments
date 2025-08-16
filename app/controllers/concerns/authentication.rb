module Authentication
  extend ActiveSupport::Concern

  private

  def current_user
    @current_user ||= decode_jwt_token
  end

  def decode_jwt_token
    token = request.headers["Authorization"]&.split(" ")&.last
    return nil unless token

    begin
      decoded = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: "HS256")
      user_id = decoded[0]["user_id"]
      User.find_by(id: user_id)
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      nil
    end
  end

  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
