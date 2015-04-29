class AddAttachmentToBeers < ActiveRecord::Migration
  def self.up
    add_attachment :beers, :attachment
  end

  def self.down
    remove_attachment :beers, :attachment
  end
end
