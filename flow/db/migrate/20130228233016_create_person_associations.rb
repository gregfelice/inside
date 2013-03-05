class CreatePersonAssociations < ActiveRecord::Migration
  def change
    create_table :person_associations do |t|
      t.text :description
      t.string :type
      t.integer :source_id
      t.integer :sink_id

      t.timestamps
    end
  end
end
