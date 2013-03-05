class CreateResourceAllocations < ActiveRecord::Migration
  def change
    create_table :resource_allocations do |t|
      t.string :comment
      t.decimal :quantity
      t.integer :milestone_id
      t.integer :person_id

      t.timestamps
    end
  end
end
