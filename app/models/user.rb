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
  has_many :followers_histories, dependent: :destroy

  validates :facebook_handle, :instagram_handle, :twitter_handle, allow_blank: true, uniqueness: true

  after_save :fetch_twitter_details, if: :saved_change_to_twitter_handle?
  after_save :fetch_instagram_details, if: :saved_change_to_instagram_handle?
  after_save :fetch_tiktok_details, if: :saved_change_to_tiktok_handle?

  def followers_at(date, platform)
    history = followers_histories.where('recorded_at <= ? AND platform = ?', date, platform).order(recorded_at: :desc).first
    history ? history.count : 0
  end

  def fetch_twitter_details
    FetchTwitterDetailsJob.perform_later(id)
  end

  def fetch_instagram_details
    FetchInstagramDetailsJob.perform_later(id)
  end

  def fetch_tiktok_details
    FetchTiktokDetailsJob.perform_later(id)
  end
end
