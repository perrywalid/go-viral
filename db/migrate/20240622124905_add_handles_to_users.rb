class AddHandlesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :facebook_handle, :string
    add_column :users, :instagram_handle, :string
    add_column :users, :twitter_handle, :string
    add_column :users, :tiktok_handle, :string

  end
end
