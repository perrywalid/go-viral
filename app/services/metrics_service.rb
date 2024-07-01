# app/services/metrics_service.rb
class MetricsService
  PLATFORM_METRICS = {
    TiktokPost: %i[view_count like_count comment_count share_count],
    Tweet: %i[views favorite_count retweet_count reply_count quote_count],
    InstagramPost: %i[like_count comment_count]
  }.freeze

  def initialize(user)
    @user = user
    @now = Time.now
    @start_of_month = @now.beginning_of_month
    @end_of_last_month = @start_of_month - 1.day
    @start_of_last_month = @end_of_last_month.beginning_of_month
  end

  def calculate_all_platforms
    results = {}

    PLATFORM_METRICS.each do |platform, metrics|
      platform_data = platform.to_s.constantize.where(user: @user)
      results[platform.to_s] = calculate_platform_metrics(platform_data, metrics, platform.to_s)
    end

    results
  end

  def calculate_platform_metrics(data, metrics, platform)
    metrics_result = {}

    metrics.each do |metric|
      metrics_result[metric] = total_metric(data, metric)
      metrics_result["#{metric}_growth_rate"] = growth_rate(data, metric)
    end

    metrics_result[:impressions] = total_metric(data, :view_count) if metrics.include?(:view_count)
    metrics_result[:impressions] = total_metric(data, :views) if metrics.include?(:views)
    metrics_result[:virality_rate] = virality_rate(data, platform)
    metrics_result[:amplification_rate] = amplification_rate(data, platform)
    metrics_result[:engagement_rate] = engagement_rate(data, platform)
    metrics_result[:audience_growth_rate] = audience_growth_rate(platform)

    metrics_result
  end

  def total_metric(data, metric)
    data.sum(metric)
  end

  def total_metric_this_month(data, metric)
    data.where('creation_date >= ?', @start_of_month).sum(metric)
  end

  def growth_rate(data, metric)
    this_month = total_metric_this_month(data, metric)
    last_month = data.where('creation_date >= ? AND creation_date <= ?', @start_of_last_month,
                            @end_of_last_month).sum(metric)
    last_month.zero? ? 0 : ((this_month - last_month).to_f / last_month * 100).round(2)
  end

  def virality_rate(data, platform)
    total_shares = case platform
                   when 'TiktokPost'
                     data.sum(:share_count)
                   when 'Tweet'
                     data.sum(:retweet_count) + data.sum(:quote_count)
                   else
                     0
                   end
    total_views = case platform
                  when 'TiktokPost'
                    data.sum(:view_count)
                  when 'Tweet'
                    data.sum(:views)
                  else
                    0
                  end

    total_views.zero? ? 0 : (total_shares.to_f / total_views * 100).round(2)
  end

  def amplification_rate(data, platform)
    total_shares = case platform
                   when 'TiktokPost'
                     data.sum(:share_count)
                   when 'Tweet'
                     data.sum(:retweet_count) + data.sum(:quote_count)
                   else
                     0
                   end
    total_followers = @user.followers_at(@now, platform)
    total_followers.zero? ? 0 : (total_shares.to_f / total_followers * 100).round(2)
  end

  def engagement_rate(data, platform)
    total_engagements = case platform
                        when 'TiktokPost'
                          data.sum(:like_count) + data.sum(:comment_count) + data.sum(:share_count)
                        when 'Tweet'
                          data.sum(:favorite_count) + data.sum(:retweet_count) + data.sum(:reply_count) + data.sum(:quote_count)
                        when 'InstagramPost'
                          data.sum(:like_count) + data.sum(:comment_count)
                        else
                          0
                        end
    total_followers = @user.followers_at(@now, platform)
    total_followers.zero? ? 0 : (total_engagements.to_f / total_followers * 100).round(2)
  end

  def audience_growth_rate(platform)
    this_month_followers = @user.followers_at(@now, platform)
    last_month_followers = @user.followers_at(@start_of_last_month, platform)
    last_month_followers = 100_000 if last_month_followers.zero?
    (((this_month_followers - last_month_followers).to_f / last_month_followers) * 100).round(2)
  end
end
