class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.boolean :contractor
      t.boolean :part_time_status
      t.string :full_name
      t.string :job_title

      t.timestamps
    end
  end
end
