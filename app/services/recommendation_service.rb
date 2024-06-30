# app/services/recommendation_service.rb
class RecommendationService
  def initialize(user, same_category: true)
    @user = user
    @same_category = same_category
  end

  def recommend_users
    users = User.where.not(id: @user.id)
    users = users.where(category: @user.category) if @same_category
    recommendations = users.map do |other_user|
      { user: other_user, similarity_score: calculate_similarity(@user, other_user) }
    end
    recommendations.sort_by { |rec| -rec[:similarity_score] }
  end

  private

  def calculate_similarity(user1, user2)
    followers_similarity = calculate_percentage_similarity(user1.total_followers, user2.total_followers)
    likes_similarity = calculate_percentage_similarity(user1.total_likes, user2.total_likes)
    engagement_similarity = calculate_percentage_similarity(user1.total_engagement, user2.total_engagement)

    (followers_similarity + likes_similarity + engagement_similarity) / 3.0
  end

  def calculate_percentage_similarity(value1, value2)
    min_value = [value1, value2].min
    max_value = [value1, value2].max
    max_value.zero? ? 0 : (min_value.to_f / max_value * 100).round(2)
  end
end
