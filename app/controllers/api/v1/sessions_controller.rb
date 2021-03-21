class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super { @token = current_token }
  end

  private

  def respond_with(_resource, _opts = {})
    render json: "access token: { Bearer #{@token} }"
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
