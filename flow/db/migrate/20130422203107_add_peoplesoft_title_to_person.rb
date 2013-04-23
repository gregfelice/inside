class AddPeoplesoftTitleToPerson < ActiveRecord::Migration
  def change
    add_column :people, :peoplesoft_title, :string
  end
end
