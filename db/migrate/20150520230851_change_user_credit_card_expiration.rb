class ChangeUserCreditCardExpiration < ActiveRecord::Migration
  def change
    rename_column :users, :year, :cc_expiration_year
    rename_column :users, :month, :cc_expiration_month
  end
end
