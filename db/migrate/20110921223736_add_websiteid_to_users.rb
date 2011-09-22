class AddWebsiteidToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :website_id, :integer
    add_index :users, [:website_id]
  end

  def self.down
    remove_column :users, :website_id
  end
end
