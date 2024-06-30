class AppStatistics
  def execute
    # Print out the statistics
    # Total number of users
    total_users = 15

    # Total number of posts per platform
    total_instagram_posts = InstagramPost.count
    total_tiktok_posts = TiktokPost.count
    total_tweets = Tweet.count

    # Average engagement metrics per platform
    average_instagram_likes = InstagramPost.average(:like_count)
    average_tiktok_views = TiktokPost.average(:view_count)
    average_tweet_likes = Tweet.average(:favorite_count)

    # Most recent post on each platform
    recent_instagram_post = InstagramPost.order(creation_date: :desc).first
    recent_tiktok_post = TiktokPost.order(creation_date: :desc).first
    recent_tweet = Tweet.order(creation_date: :desc).first

    # Print out the statistics
    puts "Total Users: #{total_users}"
    puts "Total Instagram Posts: #{total_instagram_posts}"
    puts "Total TikTok Posts: #{total_tiktok_posts}"
    puts "Total Tweets: #{total_tweets}"

    puts "Average Instagram Likes: #{average_instagram_likes}"
    puts "Average TikTok Views: #{average_tiktok_views}"
    puts "Average Tweet Likes: #{average_tweet_likes}"

    puts "Most Recent Instagram Post: #{recent_instagram_post.inspect}"
    puts "Most Recent TikTok Post: #{recent_tiktok_post.inspect}"
    puts "Most Recent Tweet: #{recent_tweet.inspect}"
  end
end
