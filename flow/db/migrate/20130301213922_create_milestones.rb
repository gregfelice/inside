class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :name
      t.text :description
      t.string :business_driver
      t.string :status
      t.string :health
      t.date :planned_start
      t.date :planned_finish

      t.timestamps
    end
  end
end
