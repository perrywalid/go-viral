# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    private
  
    def respond_with(resource, _opts = {})
      render json: resource
    end
  
    def respond_with_error(resource)
      render json: { errors: resource.errors }, status: :unprocessable_entity
    end
  end
  