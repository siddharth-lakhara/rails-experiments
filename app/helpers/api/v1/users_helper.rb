module Api::V1::UsersHelper
  def generate_jwt_token(user_id)
    payload = { user_id: user_id }
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end
end
