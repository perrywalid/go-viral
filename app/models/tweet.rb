class Tweet < ApplicationRecord
  belongs_to :user

  def day_of_week
    creation_date.strftime('%A')
  end

  def hour_of_day
    creation_date.strftime('%H').to_i
  end

  def engagement
    favorite_count + retweet_count + reply_count + quote_count
  end

  def total_score
    engagement + views
  end
end
