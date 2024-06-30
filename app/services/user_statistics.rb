require 'json'
require 'uri'
require 'net/http'

module UserStatistics
  class Scraper
    def execute
      platforms = ['facebook, twitter, instagram, tiktok, youtube']
      User.all.each do |user|
        platforms.each do |platform|
          send("#{platform}_scrape", user)
        end
      end
    end

    private

    RAPIDAPI_KEY = 'cb81197039mshde3bfda55a71ae9p14b218jsn426dcf24ffbe'.freeze

    def scrape_tiktok(user)
      url = URI("https://tiktok-scraper7.p.rapidapi.com/user/info?user_id=#{user.tiktok_handle}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['X-RapidAPI-Key'] = RAPIDAPI_KEY
      request['X-RapidAPI-Host'] = 'tiktok-scraper7.p.rapidapi.com'

      response = http.request(request)
      handle_response(response, 'tiktok', user_id)
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end

    def scrape_instagram(user)
      url = URI("https://instagram-looter2.p.rapidapi.com/profile2?username=#{user.instagram_handle}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['x-rapidapi-key'] = RAPIDAPI_KEY
      request['x-rapidapi-host'] = 'instagram-looter2.p.rapidapi.com'

      response = http.request(request)
      handle_response(response, 'instagram', username)
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end

    def handle_response(response, platform, identifier)
      if response.code == '200'
        parsed_response = JSON.parse(response.body)

        if parsed_response['code'] == 0
          stats = parsed_response['data']['stats']

          user_stat = UserStatistic.find_or_initialize_by(user_id: identifier, platform: platform)
          user_stat.update(
            following: stats['following'] || 0,
            followers: stats['followerCount'] || stats['followers'] || 0,
            posts: stats['videoCount'] || stats['posts'] || 0,
            likes: stats['heartCount'] || stats['likes'] || 0,
            comments: stats['diggCount'] || stats['comments'] || 0
          )

          puts "#{platform.capitalize} stats updated successfully for #{identifier}."
        else
          puts "Error: #{parsed_response['message'] || parsed_response['msg']}"
        end
      else
        puts "HTTP Error: #{response.code}"
      end
    end
  end
end
