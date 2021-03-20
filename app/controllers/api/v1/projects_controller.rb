class Api::V1::ProjectsController < Api::V1::ApiController
  def index
    @projects = Project.all

    render json: @projects, each_serializer: ProjectsSerializer
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def show
    @project = Project.find_by(id: params[:id])

    return render status: :not_found if @project.nil?

    render json: @project, status: :ok
  end

  def update
    @project = Project.find_by(id: params[:id])
    return render status: :not_found if @project.nil?

    return render json: @project, status: :ok if @project.update(project_params)

    render json: @project.errors, status: :unprocessable_entity
  end

  def destroy
    @project = Project.find_by(id: params[:id])
    return render status: :not_found if @project.nil?

    render status: :no_content
  end

  private

  def project_params
    project_params = params.permit(:name, navers: [])
    project_params[:naver_ids] = project_params.delete :navers
    project_params.permit!
  end
end
