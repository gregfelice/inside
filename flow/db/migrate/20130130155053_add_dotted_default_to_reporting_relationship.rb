class AddDottedDefaultToReportingRelationship < ActiveRecord::Migration
  def up
    change_column :reporting_relationships, :dotted, :boolean, :default => false
  end

  def down
    change_column :reporting_relationships, :dotted, :boolean
  end
end
