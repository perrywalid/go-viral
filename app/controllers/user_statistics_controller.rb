class UserStatisticsController < ApplicationController
  def index
    user_statistics = UserStatisticResource.all(params)
    respond_with(user_statistics)
  end

  def show
    user_statistic = UserStatisticResource.find(params)
    respond_with(user_statistic)
  end

  def create
    user_statistic = UserStatisticResource.build(params)

    if user_statistic.save
      render jsonapi: user_statistic, status: 201
    else
      render jsonapi_errors: user_statistic
    end
  end

  def update
    user_statistic = UserStatisticResource.find(params)

    if user_statistic.update_attributes
      render jsonapi: user_statistic
    else
      render jsonapi_errors: user_statistic
    end
  end

  def destroy
    user_statistic = UserStatisticResource.find(params)

    if user_statistic.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: user_statistic
    end
  end
end
