class AddPersonColumns < ActiveRecord::Migration
  def up
    add_column :people, :temporary, :boolean
    add_column :people, :hr_status, :string
    add_column :people, :part_time, :boolean
    add_column :people, :band, :string
    add_column :people, :cost_center, :string
    add_column :people, :business_unit, :string
    add_column :people, :hiring_status, :string
  end

  def down
    remove_column :people, :temporary
    remove_column :people, :hr_status
    remove_column :part_time
    remove_column :band
    remove_column :cost_center
    remove_column :business_unit
    remove_column :hiring_status
  end
end
