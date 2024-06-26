# app/services/tweet_fetcher_service.rb
require 'net/http'
require 'json'

class TweetFetcherService
  API_KEY = 'cb81197039mshde3bfda55a71ae9p14b218jsn426dcf24ffbe'
  API_HOST = 'twitter154.p.rapidapi.com'

  def initialize(user)
    @user = user
  end

  def fetch_and_store_tweets
    fetched_tweets = []
    continuation_token = nil

    while fetched_tweets.size < 1000
      if continuation_token
        response = fetch_continuation_tweets(continuation_token)
      else
        response = fetch_initial_tweets
      end

      tweets, continuation_token = parse_response(response)

      tweets.each do |tweet|
        next if Tweet.exists?(tweet_id: tweet['tweet_id'])

        Tweet.create!(
          post_id: SecureRandom.uuid,
          user_id: @user.id,
          tweet_id: tweet['tweet_id'],
          creation_date: DateTime.parse(tweet['creation_date']),
          text: tweet['text'],
          language: tweet['language'],
          favorite_count: tweet['favorite_count'],
          retweet_count: tweet['retweet_count'],
          reply_count: tweet['reply_count'],
          quote_count: tweet['quote_count'],
          views: tweet['views'],
        )

        fetched_tweets << tweet
        break if fetched_tweets.size >= 100
      end

      break if continuation_token.nil?
    end
  end

  private

  def fetch_initial_tweets
    url = URI("https://#{API_HOST}/user/tweets?username=#{@user.twitter_handle}&limit=20&include_replies=false&include_pinned=false")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = API_KEY
    request['x-rapidapi-host'] = API_HOST

    response = http.request(request)
    JSON.parse(response.body)
  end

  def fetch_continuation_tweets(continuation_token)
    url = URI("https://#{API_HOST}/user/tweets/continuation?username=#{@user.twitter_handle}&limit=20&continuation_token=#{URI.encode(continuation_token)}&include_replies=false")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = API_KEY
    request['x-rapidapi-host'] = API_HOST

    response = http.request(request)
    JSON.parse(response.body)
  end

  def parse_response(response)
    tweets = response['results']
    continuation_token = response['continuation_token']
    [tweets, continuation_token]
  end
end
