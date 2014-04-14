class AddUsernameToDemographics < ActiveRecord::Migration
  def change
  	  add_column :demographics, :username, :string
  end
end
