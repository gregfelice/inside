class DropOldTables < ActiveRecord::Migration
  def up
    drop_table :employees
    drop_table :reporting_relationships
    drop_table :screws
  end

  def down
  end
end
