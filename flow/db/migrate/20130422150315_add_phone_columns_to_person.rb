class AddPhoneColumnsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :office_phone, :string
    add_column :people, :cell_phone, :string
  end
end
