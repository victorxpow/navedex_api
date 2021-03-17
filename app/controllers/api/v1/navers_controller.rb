class Api::V1::NaversController < Api::V1::ApiController
  def index
    @navers = Naver.all

    render json: @navers
  end
end
