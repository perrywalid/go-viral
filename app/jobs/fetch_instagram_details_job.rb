# app/jobs/fetch_instagram_details_job.rb
require 'uri'
require 'net/http'

class FetchInstagramDetailsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    instagram_handle = user.instagram_handle

    url = URI("https://instagram-scraper-api2.p.rapidapi.com/v1/info?username_or_id_or_url=#{instagram_handle}&include_about=true")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = 'cb81197039mshde3bfda55a71ae9p14b218jsn426dcf24ffbe'
    request['x-rapidapi-host'] = 'instagram-scraper-api2.p.rapidapi.com'

    response = http.request(request)
    details = JSON.parse(response.body)['data']

    user.update(
      instagram_name: details['full_name'],
      instagram_follower_count: details['follower_count'],
      instagram_following_count: details['following_count'],
      instagram_biography: details['biography'],
      instagram_media_count: details['media_count'],
      instagram_is_verified: details['about']['is_verified']
    )
    user.followers_histories.create!(count: details['follower_count'], platform: 'InstagramPost', recorded_at: Time.current)
  rescue StandardError => e
    Rails.logger.error "Failed to fetch Instagram details: #{e.message}"
  end
end
