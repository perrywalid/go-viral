# app/jobs/fetch_tiktok_details_job.rb
require 'uri'
require 'net/http'

class FetchTiktokDetailsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    tiktok_handle = user.tiktok_handle

    url = URI("https://tiktok-scraper7.p.rapidapi.com/user/info?unique_id=#{tiktok_handle}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = 'cb81197039mshde3bfda55a71ae9p14b218jsn426dcf24ffbe'
    request['x-rapidapi-host'] = 'tiktok-scraper7.p.rapidapi.com'

    response = http.request(request)
    details = JSON.parse(response.body)['data']['user']
    stats = JSON.parse(response.body)['data']['stats']

    user.update(
      tiktok_nickname: details['nickname'],
      tiktok_follower_count: stats['followerCount'],
      tiktok_following_count: stats['followingCount'],
      tiktok_heart_count: stats['heartCount'],
      tiktok_video_count: stats['videoCount'],
      tiktok_signature: details['signature'],
      tiktok_is_verified: details['verified']
    )
    user.followers_histories.create!(count: stats['followerCount'], platform: 'Tiktok', recorded_at: Time.current)
  rescue StandardError => e
    Rails.logger.error "Failed to fetch TikTok details: #{e.message}"
  end
end
