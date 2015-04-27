class CreateBeerCategories < ActiveRecord::Migration
  def change
    create_table :beer_categories do |t|
      t.references :category, index: true, foreign_key: true
      t.references :beer, index: true, foreign_key: true
    end
  end
end
