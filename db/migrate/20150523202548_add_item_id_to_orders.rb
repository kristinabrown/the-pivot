class AddItemIdToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :item, index: true, foreign_key: true
    remove_column :orders, :status
  end
end
