class AddPlatformToFollowersHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :followers_histories, :platform, :string
  end
end
