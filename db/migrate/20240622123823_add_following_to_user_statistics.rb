class AddFollowingToUserStatistics < ActiveRecord::Migration[7.1]
  def change
    add_column :user_statistics, :following, :integer
  end
end
