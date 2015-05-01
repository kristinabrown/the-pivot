class DropUserBeersTable < ActiveRecord::Migration
  def change
    drop_table :user_beers
  end
end
