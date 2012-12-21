class CreateReportingRelationships < ActiveRecord::Migration
  def change
    create_table :reporting_relationships do |t|
      t.integer :employee
      t.integer :supervisor
      t.boolean :dotted

      t.timestamps
    end
  end
end
