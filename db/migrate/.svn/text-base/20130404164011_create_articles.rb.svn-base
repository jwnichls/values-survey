class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string      :title
      t.string      :url
      t.integer     :page_view_count
      t.string      :source 
      t.integer     :type_id
      t.integer     :within_type_id
      t.string      :tweet_path      
      t.string      :content_path
    end
  end
end
