# app/services/instagram_post_fetcher_service.rb
require 'net/http'
require 'json'

class InstagramPostFetcherService
  API_KEY = 'cb81197039mshde3bfda55a71ae9p14b218jsn426dcf24ffbe'
  API_HOST = 'instagram-scraper-api2.p.rapidapi.com'

  def initialize(user)
    @user = user
  end

  def fetch_and_store_posts
    fetched_posts = []
    pagination_token = nil

    while fetched_posts.size < 200
      if pagination_token
        response = fetch_continuation_posts(pagination_token)
      else
        response = fetch_initial_posts
      end

      posts, pagination_token = parse_response(response)
      posts.each do |post|
        next if InstagramPost.exists?(instagram_post_id: post['id'])

        InstagramPost.create!(
          post_id: SecureRandom.uuid,
          user_id: @user.id,
          instagram_post_id: post['id'],
          creation_date: Time.at(post['taken_at']),
          text: post['caption'],
          media_type: post['media_type'],
          like_count: post['like_count'],
          comment_count: post['comment_count'],
          view_count: post['view_count'],
          thumbnail_url: post['thumbnail_url'],
          video_url: post['video_url'],
        )

        fetched_posts << post
        break if fetched_posts.size >= 200
      end

      break if pagination_token.nil?
    end
  end

  private

  def fetch_initial_posts
    url = URI("https://#{API_HOST}/v1.2/posts?username_or_id_or_url=#{@user.instagram_handle}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = API_KEY
    request['x-rapidapi-host'] = API_HOST

    response = http.request(request)

    JSON.parse(response.body)
  end

  def fetch_continuation_posts(pagination_token)
    url = URI("https://#{API_HOST}/v1.2/posts?username_or_id_or_url=#{@user.instagram_handle}&pagination_token=#{URI.encode(pagination_token)}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = API_KEY
    request['x-rapidapi-host'] = API_HOST

    response = http.request(request)
    JSON.parse(response.body)
  end

  def parse_response(response)
    posts = response['data']['items']
    pagination_token = response['pagination_token']
    [posts, pagination_token]
  end
end
