# app/services/post_timing_service.rb
class PostTimingService
  def initialize(user, platform)
    @user = user
    @platform = platform.constantize
  end

  def total_score_by_day
    calculate_total_scores('day')
  end

  def total_score_by_hour
    calculate_total_scores('hour')
  end

  def best_time_to_post
    scores_by_day = total_score_by_day
    scores_by_hour = total_score_by_hour

    best_day = scores_by_day.max_by { |_day, score| score }.first
    best_hour = scores_by_hour.max_by { |_hour, score| score }.first

    { best_day: best_day, best_hour: best_hour }
  end

  private

  def calculate_total_scores(time_unit)
    posts = @platform.where(user: @user)
    grouped_posts = group_posts_by_time(posts, time_unit)
    calculate_scores(grouped_posts)
  end

  def group_posts_by_time(posts, time_unit)
    grouped = Hash.new { |hash, key| hash[key] = { engagement: 0, views: 0 } }
    posts.each do |post|
      time_key = case time_unit
                 when 'day' then post.day_of_week
                 when 'hour' then post.hour_of_day
                 end

      grouped[time_key][:engagement] += post.engagement ? post.engagement : 0
      grouped[time_key][:views] += post.views ? post.views : 0
    end

    grouped
  end

  def calculate_scores(grouped_posts)
    scores = {}
    grouped_posts.each do |time_key, data|
      engagement = data[:engagement]
      views = data[:views]

      scores[time_key] = engagement + views
    end

    scores
  end
end
