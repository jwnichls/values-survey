class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string    :worker_id
      t.string    :hit_id
      t.string    :assignment_id
      t.integer   :condition
      t.string    :article_within_type_id_array
      t.string    :article_type_id_array        
      t.timestamps
    end
  end
end
