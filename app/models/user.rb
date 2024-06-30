# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :user_statistics
  has_many :tweets
  has_many :instagram_posts
  has_many :tiktok_posts
  has_many :calendar_events

  validates :facebook_handle, :instagram_handle, :twitter_handle, allow_blank: true, uniqueness: true
end


