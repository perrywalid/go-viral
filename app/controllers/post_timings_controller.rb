# app/controllers/post_timings_controller.rb
class PostTimingsController < ApplicationController
    def total_score_by_day
      user = User.find(params[:user_id])
      platform = params[:platform]
  
      service = PostTimingService.new(user, platform)
      scores = service.total_score_by_day
  
      render json: scores, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  
    def total_score_by_hour
      user = User.find(params[:user_id])
      platform = params[:platform]
  
      service = PostTimingService.new(user, platform)
      scores = service.total_score_by_hour
  
      render json: scores, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  
    def best_time_to_post
      user = User.find(params[:user_id])
      platform = params[:platform]
  
      service = PostTimingService.new(user, platform)
      best_times = service.best_time_to_post
  
      render json: best_times, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
  