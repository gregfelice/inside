class RenamePersonAssociationColumn < ActiveRecord::Migration
  def up
    rename_column(:person_associations, "type", "person_type")
  end

  def down
    rename_column(:person_associations, "person_type", "type")
  end
end
