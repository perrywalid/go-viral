# app/resources/user_statistic_resource.rb
class UserStatisticResource < ApplicationResource
    attribute :id, :integer, writable: false
    attribute :user_id, :integer
    attribute :platform, :string
    attribute :followers, :integer
    attribute :following, :integer
    attribute :posts, :integer
    attribute :likes, :integer
    attribute :comments, :integer
  
    belongs_to :user
  end
  