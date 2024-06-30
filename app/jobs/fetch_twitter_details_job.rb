# app/jobs/fetch_twitter_details_job.rb
require 'uri'
require 'net/http'

class FetchTwitterDetailsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    twitter_handle = user.twitter_handle

    url = URI("https://twitter154.p.rapidapi.com/user/details?username=#{twitter_handle}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = 'cb81197039mshde3bfda55a71ae9p14b218jsn426dcf24ffbe'
    request['x-rapidapi-host'] = 'twitter154.p.rapidapi.com'

    response = http.request(request)
    details = JSON.parse(response.body)

    user.update(
      twitter_name: details['name'],
      twitter_follower_count: details['follower_count'],
      twitter_following_count: details['following_count'],
      twitter_favourites_count: details['favourites_count'],
      twitter_is_verified: details['is_verified'],
      twitter_description: details['description'],
      twitter_number_of_tweets: details['number_of_tweets']
    )
    user.followers_histories.create!(count: details['follower_count'], platform: 'Twitter', recorded_at: Time.current)
  rescue StandardError => e
    Rails.logger.error "Failed to fetch Twitter details: #{e.message}"
  end
end
