Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    scope :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/registrations'
        }
    end
  end
end
