module Api::V1::UsersHelper
  def generate_jwt_token(user_id)
    payload = { user_id: user_id }
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end

  def decode_jwt_token(token)
    JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
  end
end
