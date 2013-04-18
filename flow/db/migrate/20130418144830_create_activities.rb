class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :summary
      t.string :owner

      t.timestamps
    end
  end
end
