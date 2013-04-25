class ChangeMilestoneAndPlanForeignKeys < ActiveRecord::Migration
  def up
    remove_column :resource_allocations, :milestone_id
    add_column :resource_allocations, :plan_id, :integer
  end

  def down
    add_column :resource_allocations, :milestone_id, :integer
    remove_column :resource_allocations, :plan_id
  end
end
