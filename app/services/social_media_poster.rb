# app/services/social_media_poster.rb
require 'net/http'
require 'json'
require 'mini_magick'

class SocialMediaPoster
  INSTAGRAM_WEBHOOK_URL = 'https://hooks.zapier.com/hooks/catch/19240729/2b1qby8/'
  FACEBOOK_X_WEBHOOK_URL = 'https://hooks.zapier.com/hooks/catch/19240729/2bmslsa/'

  def initialize(text, image)
    @text = text
    @image = image
  end

  def post_to_all_platforms
    begin
      processed_image = process_image_for_instagram(@image)
      instagram_response = post_to_instagram(@text, processed_image)
      facebook_x_response = post_to_facebook_and_x(@text, processed_image)

      if instagram_response.code.to_i == 200 && facebook_x_response.code.to_i == 200
        { success: true }
      else
        { success: false, error: "Failed to post on one or more platforms" }
      end
    rescue StandardError => e
      { success: false, error: e.message }
    end
  end

  private

  def process_image_for_instagram(image)
    processed_image = MiniMagick::Image.read(image)
    processed_image.resize "1080x1080"
    processed_image.format "jpg"
    processed_image
  end

  def post_to_instagram(text, image)
    uri = URI("#{INSTAGRAM_WEBHOOK_URL}?title=#{URI.encode_www_form_component(text)}")
    request = Net::HTTP::Post.new(uri)
    form_data = [['file', image.to_blob, { filename: 'image.jpg', content_type: 'image/jpeg' }]]
    request.set_form(form_data, 'multipart/form-data')

    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true
    http.request(request)
  end

  def post_to_facebook_and_x(text, image)
    uri = URI("#{FACEBOOK_X_WEBHOOK_URL}?title=#{URI.encode_www_form_component(text)}")
    request = Net::HTTP::Post.new(uri)
    form_data = [['file', image.to_blob, { filename: 'image.jpg', content_type: 'image/jpeg' }]]
    request.set_form(form_data, 'multipart/form-data')

    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true
    http.request(request)
  end
end
