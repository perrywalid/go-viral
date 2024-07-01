# app/resources/user_resource.rb
class UserResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :email, :string
  attribute :facebook_handle, :string
  attribute :instagram_handle, :string
  attribute :twitter_handle, :string
  attribute :tiktok_handle, :string
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :category_id, :integer
  attribute :twitter_follower_count, :integer
  attribute :instagram_follower_count, :integer
  attribute :tiktok_follower_count, :integer
  attribute :twitter_like_count, :integer
  attribute :instagram_like_count, :integer
  attribute :tiktok_like_count, :integer
  attribute :total_engagement, :integer
  attribute :total_followers, :integer
  attribute :total_likes, :integer
  attribute :twitter_description, :string
  attribute :twitter_number_of_tweets, :integer
  attribute :instagram_biography, :string
  attribute :instagram_media_count, :integer
  attribute :twitter_name, :string
  attribute :twitter_following_count, :integer
  attribute :twitter_favourites_count, :integer
  attribute :twitter_is_verified, :boolean
  attribute :instagram_name, :string
  attribute :instagram_following_count, :integer
  attribute :instagram_is_verified, :boolean
  attribute :tiktok_nickname, :string
  attribute :tiktok_following_count, :integer
  attribute :tiktok_heart_count, :integer
  attribute :tiktok_video_count, :integer
  attribute :tiktok_signature, :string
  attribute :tiktok_is_verified, :boolean
  attribute :photo_url, :string

  has_many :user_statistics

  filter :email, :string
end
