# app/controllers/metrics_controller.rb
class MetricsController < ApplicationController
    def show
      user = User.find(params[:user_id])
      service = MetricsService.new(user)
  
      metrics = service.calculate_all_platforms
  
      render json: metrics, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
  