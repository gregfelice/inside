class ChangeReportingRelationshipColumns < ActiveRecord::Migration

  # changing this in hopes it makes activeadmin happy
  def up
    change_table :reporting_relationships do |t|
      t.rename :employee, :employee_id
      t.rename :supervisor, :supervisor_id
    end
  end

  def down
    change_table :reporting_relationships do |t|
      t.rename :employee_id, :employee

      t.rename :supervisor_id, :supervisor
    end
  end
end
