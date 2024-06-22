class CreateUserStatistics < ActiveRecord::Migration[7.1]
  def change
    create_table :user_statistics do |t|
      t.references :user, null: false, foreign_key: true
      t.string :platform
      t.integer :followers
      t.integer :posts
      t.integer :likes
      t.integer :comments

      t.timestamps
    end
  end
end
