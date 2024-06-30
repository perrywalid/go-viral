# app/models/followers_history.rb
class FollowersHistory < ApplicationRecord
  belongs_to :user

  validates :count, presence: true
  validates :recorded_at, presence: true
end
