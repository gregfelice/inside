class AddRelationBetweenUserAndPerson < ActiveRecord::Migration

  def up
    add_column :users, :person_id, :integer
  end

  def down
    remove_column :users, :person_id
  end

end
