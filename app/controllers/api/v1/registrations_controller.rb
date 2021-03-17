class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save

    if resource.errors.empty?
      render json: resource, status: :created
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
end
