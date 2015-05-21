class ChangeExpirDateType < ActiveRecord::Migration
  def change
    remove_column :users, :cc_expiration_date

  end
end
