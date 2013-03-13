class AddColumnToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :facing, :string
  end
end
