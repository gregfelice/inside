class RenamePersonColumn < ActiveRecord::Migration
  def up
    rename_column(:people, "type", "person_type")
  end

  def down
    rename_column(:people, "person_type", "type")
  end
end
