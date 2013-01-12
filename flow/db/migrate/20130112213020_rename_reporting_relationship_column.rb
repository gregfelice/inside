class RenameReportingRelationshipColumn < ActiveRecord::Migration
  def up
    rename_column :reporting_relationships, :employee_id, :subordinate_id
  end

  def down
    rename_column :reporting_relationships, :subordinate_id, :employee_id
  end
end
