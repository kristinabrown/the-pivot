class CreateUserBeers < ActiveRecord::Migration
  def change
    create_table :user_beers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :beer, index: true, foreign_key: true
    end
  end
end
