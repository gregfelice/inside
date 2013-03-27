class AddColumnsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :location_floor, :string
    add_column :people, :location_code, :string
  end
end
