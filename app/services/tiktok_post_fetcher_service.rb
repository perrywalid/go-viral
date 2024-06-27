# app/services/tiktok_post_fetcher_service.rb
require 'net/http'
require 'json'

class TiktokPostFetcherService
  API_KEY = 'cb81197039mshde3bfda55a71ae9p14b218jsn426dcf24ffbe'
  API_HOST = 'tiktok-scraper7.p.rapidapi.com'

  def initialize(user)
    @user = user
  end

  def fetch_and_store_posts
    fetched_posts = []
    cursor = 0

    while fetched_posts.size < 200
      response = fetch_posts(cursor)
      posts, cursor = parse_response(response)

      posts.each do |post|
        next if TiktokPost.exists?(tiktok_post_id: post['aweme_id'])

        TiktokPost.create!(
          post_id: SecureRandom.uuid,
          user_id: @user.id,
          tiktok_post_id: post['aweme_id'],
          creation_date: Time.at(post['create_time']),
          text: post['title'],
          media_type: post['media_type'],
          like_count: post['digg_count'],
          comment_count: post['comment_count'],
          share_count: post['share_count'],
          view_count: post['play_count'],
          video_url: post['play'],
        )

        fetched_posts << post
        break if fetched_posts.size >= 200
      end

      break if cursor.nil?
    end
  end

  private

  def fetch_posts(cursor)
    url = URI("https://#{API_HOST}/user/posts?unique_id=#{@user.tiktok_handle}&count=30&cursor=#{cursor}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = API_KEY
    request['x-rapidapi-host'] = API_HOST

    response = http.request(request)
    JSON.parse(response.body)
  end

  def parse_response(response)
    posts = response['data']['videos']
    cursor = response['data']['cursor']
    [posts, cursor]
  end
end
