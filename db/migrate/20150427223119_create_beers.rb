class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.boolean :state
      t.references :category, index: true, foreign_key: true
      t.string :description
      t.integer :price

      t.timestamps
    end
  end

  def up
    add_attachment :beers, :image
  end

  def down
    remove_attachment :beers, :image
  end

end