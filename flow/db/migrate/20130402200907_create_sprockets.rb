class CreateSprockets < ActiveRecord::Migration
  def change
    create_table :sprockets do |t|
      t.string :name
      t.boolean :winner

      t.timestamps
    end
  end
end
