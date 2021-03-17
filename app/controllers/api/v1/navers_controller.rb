class Api::V1::NaversController < Api::V1::ApiController
  before_action :authenticate_user!

  def index
    @navers = Naver.all

    render json: @navers
  end

  def create
    @naver = Naver.new(naver_params)
    @naver.user = current_user

    if @naver.save
      render json: @naver, status: :created
    else
      render json: @naver.errors, status: :unprocessable_entity
    end
  end

  def show
    @naver = Naver.find_by_id(params[:id])

    return render status: :not_found if @naver.nil?

    render json: @naver, status: :ok
  end

  private

  def naver_params
    params.permit(:name, :birthdate, :admission_date, :job_role)
  end
end
