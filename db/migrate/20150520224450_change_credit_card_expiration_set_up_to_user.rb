class ChangeCreditCardExpirationSetUpToUser < ActiveRecord::Migration
  def change
    rename_column :users, :credit_card_exp_date, :year
    add_column :users, :month, :date
  end
end
