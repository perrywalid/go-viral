# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def create
    text = params[:text]
    image = params[:image]

    if text.blank? || image.blank?
      render json: { error: 'Text and image are required' }, status: :unprocessable_entity
      return
    end

    result = SocialMediaPoster.new(text, image).post_to_all_platforms

    if result[:success]
      render json: { message: 'Post successfully created on all platforms' }, status: :ok
    else
      render json: { error: result[:error] }, status: :unprocessable_entity
    end
  end
end
