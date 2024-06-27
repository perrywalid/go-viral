class CreateTiktokPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :tiktok_posts do |t|
      t.string :post_id
      t.integer :user_id
      t.string :tiktok_post_id
      t.datetime :creation_date
      t.text :text
      t.string :media_type
      t.integer :like_count
      t.integer :comment_count
      t.integer :share_count
      t.integer :view_count
      t.string :video_url

      t.timestamps
    end
  end
end
