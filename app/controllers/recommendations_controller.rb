# app/controllers/recommendations_controller.rb
class RecommendationsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    same_category = params[:same_category] == 'true'

    service = RecommendationService.new(user, same_category: same_category)
    recommendations = service.recommend_users

    render json: recommendations, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
