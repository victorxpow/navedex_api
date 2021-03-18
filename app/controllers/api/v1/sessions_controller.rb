class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super { @token = current_token }
  end

  private

  def respond_with(resource, _opts = {})
    render json: "access token: { Bearer #{@token} }"
  end

  def respond_to_on_destroy
    head :no_content
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
