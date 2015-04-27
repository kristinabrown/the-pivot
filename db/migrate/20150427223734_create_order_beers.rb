class CreateOrderBeers < ActiveRecord::Migration
  def change
    create_table :order_beers do |t|
      t.references :order, index: true, foreign_key: true
      t.references :beer, index: true, foreign_key: true
      t.integer :quantity
    end
  end
end
