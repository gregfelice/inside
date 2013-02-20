class AddIndexes < ActiveRecord::Migration

  def self.up
    add_index(:reporting_relationships, [ :subordinate_id, :supervisor_id ], :name => "idx_subordinate_and_supervisor_id")
    add_index(:reporting_relationships, :supervisor_id, :name => "idx_supervisor_id")
  end

  def self.down
    remove_index :reporting_relationships, :name => :idx_subordinate_and_supervisor_id
    remove_index :reporting_relationships, :name => :idx_supervisor_id
  end
end
