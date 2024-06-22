# app/models/user_statistic.rb
class UserStatistic < ApplicationRecord
  belongs_to :user

  validates :following, :followers, :posts, :likes, :comments, presence: true
end
