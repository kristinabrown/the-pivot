class UpdateCreditCardInfo < ActiveRecord::Migration
  def change
    remove_column :users, :cc_expiration_year, :date
    remove_column :users, :cc_expiration_month, :date
    add_column :users, :cc_expiration_date, :string
  end
end
