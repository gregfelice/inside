class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.text :description
      t.string :type
      t.integer :group_id
      t.integer :person_id

      t.timestamps
    end
  end
end
