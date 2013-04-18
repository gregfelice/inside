class RenameSprockets < ActiveRecord::Migration
  def self.up
    rename_table :sprockets, :screws
  end

  def self.down
    rename_table :screws, :sprockets
  end

end
