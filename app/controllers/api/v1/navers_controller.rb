class Api::V1::NaversController < Api::V1::ApiController
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
    @naver = Naver.find_by(id: params[:id])

    return render status: :not_found if @naver.nil?

    render json: @naver, status: :ok
  end

  def update
    @naver = Naver.find_by(id: params[:id])
    return render status: :not_found if @naver.nil?

    return render json: @naver, status: :ok if @naver.update(naver_params)

    render json: @naver.errors, status: :unprocessable_entity
  end

  def destroy
    @naver = Naver.find_by(id: params[:id])
    return render status: :not_found if @naver.nil?

    render status: :no_content
  end

  private

  def naver_params
    naver_params = params.permit(:name, :birthdate, :admission_date, :job_role, projects: [])
    naver_params[:project_ids] = naver_params.delete :projects
    naver_params.permit!
  end
end
