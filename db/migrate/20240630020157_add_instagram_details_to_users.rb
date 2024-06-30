class AddInstagramDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :instagram_name, :string
    add_column :users, :instagram_follower_count, :integer
    add_column :users, :instagram_following_count, :integer
    add_column :users, :instagram_biography, :text
    add_column :users, :instagram_media_count, :integer
    add_column :users, :instagram_is_verified, :boolean
  end
end
