class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text
      t.string :id
      t.integer :favorites_count
      t.integer :retweet_count
      t.datetime :time
      t.string :user_uid
      t.timestamps
    end
  end
end
