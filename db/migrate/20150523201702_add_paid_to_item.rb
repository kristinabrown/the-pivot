class AddPaidToItem < ActiveRecord::Migration
  def change
    add_column :items, :paid, :boolean, default: false
  end
end
