class AddColumnsToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :level, :string
    add_column :employees, :cost_center, :string
  end
end
