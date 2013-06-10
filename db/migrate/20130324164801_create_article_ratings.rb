class CreateArticleRatings < ActiveRecord::Migration
  def change
    create_table :article_ratings do |t|
      t.integer :participant_id
      t.integer :article_id
      t.integer :rating_01
      t.integer :rating_02
      t.integer :rating_03
      t.integer :rating_04
      t.integer :rating_05

      
      t.timestamps
    end
  end
end
