class AddExpirDateTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cc_expiration_date, :date
  end
end
