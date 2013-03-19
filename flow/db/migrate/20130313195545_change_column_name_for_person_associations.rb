class ChangeColumnNameForPersonAssociations < ActiveRecord::Migration
  def up
    rename_column :person_associations, :person_type, :association_type
  end

  def down
    rename_column :person_associations, :association_type, :person_type
  end
end
