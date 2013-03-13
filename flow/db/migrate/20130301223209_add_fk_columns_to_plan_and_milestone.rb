class AddFkColumnsToPlanAndMilestone < ActiveRecord::Migration
  def change
    add_column :plans, :portfolio_id, :integer
    add_column :milestones, :plan_id, :integer
  end
end
