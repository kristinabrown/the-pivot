class ChangeCreditCardToString < ActiveRecord::Migration
  def change
    change_column :users, :credit_card, :string
  end
end
