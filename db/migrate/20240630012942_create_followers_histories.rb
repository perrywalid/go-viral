class CreateFollowersHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :followers_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :count
      t.datetime :recorded_at

      t.timestamps
    end
  end
end
