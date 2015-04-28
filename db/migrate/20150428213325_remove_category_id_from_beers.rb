class RemoveCategoryIdFromBeers < ActiveRecord::Migration
  def change
    remove_column :beers, :category_id
  end
end
