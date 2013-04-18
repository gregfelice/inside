class AddPersonColumnsPmoRelated < ActiveRecord::Migration
  def up
    add_column :people, :budget, :string
    add_column :people, :seating, :string
    add_column :people, :employment_start_date, :date
    add_column :people, :employment_end_date, :date
    add_column :people, :group, :string
  end

  def down
    removecolumn :people, :budget
    remove_column :people, :seating
    remove_column :people, :employment_start_date
    remove_column :people, :employment_end_date
    remove_column :people, :group
  end
end
