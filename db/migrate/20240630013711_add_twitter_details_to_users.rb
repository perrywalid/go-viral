class AddTwitterDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :twitter_name, :string
    add_column :users, :twitter_follower_count, :integer
    add_column :users, :twitter_following_count, :integer
    add_column :users, :twitter_favourites_count, :integer
    add_column :users, :twitter_is_verified, :boolean
    add_column :users, :twitter_description, :text
    add_column :users, :twitter_number_of_tweets, :integer
  end
end
