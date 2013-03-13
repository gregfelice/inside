class CreateGroupAssociations < ActiveRecord::Migration
  def change
    create_table :group_associations do |t|
      t.string :name
      t.text :description
      t.string :type
      t.integer :source_id
      t.integer :sink_id

      t.timestamps
    end
  end
end
