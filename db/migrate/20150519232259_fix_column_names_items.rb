class FixColumnNamesItems < ActiveRecord::Migration
  def change
    rename_column :items, :state, :active
    rename_column :items, :price, :starting_price
    add_column :items, :expiration_date, :datetime
    add_reference :items, :store, index: true
    add_reference :items, :category, index: true
  end
end
