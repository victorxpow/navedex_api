class Api::V1::NaversController < Api::V1::ApiController
  before_action :set_naver, only: [:update, :show, :destroy]
  
  def index
    @navers = Naver.all

    render json: @navers, each_serializer: NaversSerializer
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
    render json: @naver, status: :ok
  end

  def update
    @naver.update(naver_params) if naver_params.nil?

    return render json: @naver, status: :ok if @naver.update(naver_params)

    render json: @naver.errors, status: :unprocessable_entity
  end


  def destroy
    render status: :no_content
  end

  private

  def set_naver
    @naver = Naver.find_by(id: params[:id])
    return render status: :not_found if @naver.nil?
    @naver
  end

  def naver_params
    naver_params = params.permit(:name, :birthdate, :admission_date, :job_role, projects: [])
    naver_params[:project_ids] = naver_params.delete :projects
    naver_params.permit!
  end
end
