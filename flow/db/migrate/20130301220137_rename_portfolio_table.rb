class RenamePortfolioTable < ActiveRecord::Migration
  def up
    rename_table :portflios, "portfolios"
  end

  def down
    rename_table :portfolios, "portflios"
  end
end
