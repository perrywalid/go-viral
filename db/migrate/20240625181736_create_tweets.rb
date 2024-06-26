class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.string :post_id
      t.integer :user_id
      t.string :tweet_id
      t.datetime :creation_date
      t.text :text
      t.string :language
      t.integer :favorite_count
      t.integer :retweet_count
      t.integer :reply_count
      t.integer :quote_count
      t.integer :views

      t.timestamps
    end
  end
end
