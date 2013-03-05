class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.text :description
      t.string :portfolio_category

      t.timestamps
    end
  end
end
