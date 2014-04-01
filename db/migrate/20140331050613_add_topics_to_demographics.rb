class AddTopicsToDemographics < ActiveRecord::Migration
  def change
  	add_column :demographics, :topic_05, :integer
  	add_column :demographics, :topic_06, :integer
  	add_column :demographics, :topic_07, :integer
  	add_column :demographics, :topic_08, :integer
  	add_column :demographics, :topic_09, :integer
  	add_column :demographics, :topic_10, :integer
  end
end
