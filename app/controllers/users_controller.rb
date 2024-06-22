# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def show
    user = UserResource.find(params)
    render jsonapi: user
  end

  def create
    user = UserResource.build(params)

    if user.save
      render jsonapi: user, status: :created
    else
      render jsonapi_errors: user
    end
  end

  def update
    user = UserResource.find(params)

    if user.update_attributes
      render jsonapi: user
    else
      render jsonapi_errors: user
    end
  end

  def destroy
    user = UserResource.find(params)
    user.destroy
    head :no_content
  end
end
