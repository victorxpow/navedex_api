module Api
  module V1
    class ApiController < ActionController::API
      before_action :authenticate_user!
    end
  end
end
