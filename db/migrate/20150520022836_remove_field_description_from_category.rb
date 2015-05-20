class RemoveFieldDescriptionFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :description, :string
  end
end
