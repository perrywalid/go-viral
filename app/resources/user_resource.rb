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
  
    has_many :user_statistics
  
    filter :email, :string
  end
  