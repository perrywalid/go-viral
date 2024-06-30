class AddTiktokDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :tiktok_nickname, :string
    add_column :users, :tiktok_follower_count, :integer
    add_column :users, :tiktok_following_count, :integer
    add_column :users, :tiktok_heart_count, :integer
    add_column :users, :tiktok_video_count, :integer
    add_column :users, :tiktok_signature, :text
    add_column :users, :tiktok_is_verified, :boolean
  end
end
