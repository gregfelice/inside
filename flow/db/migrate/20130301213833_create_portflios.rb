class CreatePortflios < ActiveRecord::Migration
  def change
    create_table :portflios do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
