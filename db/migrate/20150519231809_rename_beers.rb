class RenameBeers < ActiveRecord::Migration
  def change
    rename_table :beers, :items
  end
end
