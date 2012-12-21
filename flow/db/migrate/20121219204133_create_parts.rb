class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :commenter
      t.text :description
      t.references :widget

      t.timestamps
    end
    add_index :parts, :widget_id
  end
end
