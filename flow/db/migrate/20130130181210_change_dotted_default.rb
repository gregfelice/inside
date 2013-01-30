class ChangeDottedDefault < ActiveRecord::Migration
  def up
    change_column :reporting_relationships, :dotted, :boolean, :default => 0
  end

  def down
    change_column :reporting_relationships, :dotted, :boolean
  end
end
