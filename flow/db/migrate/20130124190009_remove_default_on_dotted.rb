class RemoveDefaultOnDotted < ActiveRecord::Migration



  def up
    change_column :reporting_relationships, :dotted, :boolean, :default => nil
  end

  def down
    change_column :reporting_relationships, :dotted, :boolean, :default => false
  end

end
