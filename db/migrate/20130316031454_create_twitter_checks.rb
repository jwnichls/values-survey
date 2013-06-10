class CreateTwitterChecks < ActiveRecord::Migration
  def change
    create_table :twitter_checks do |t|
      t.string :user_name
      t.string :password
      t.timestamps
    end
  end
end
