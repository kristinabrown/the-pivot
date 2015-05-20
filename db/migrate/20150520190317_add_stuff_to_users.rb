class AddStuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :street, :string
    add_column :users, :apt_number, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zipcode, :integer
    add_column :users, :credit_card, :integer
    add_column :users, :credit_card_exp_date, :date
  end
end
