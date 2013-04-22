class AddRoleColumnToPerson < ActiveRecord::Migration
  def change
    add_column :people, :person_role, :string
    add_column :people, :person_focus, :string
  end
end
