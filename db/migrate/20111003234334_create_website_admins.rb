class CreateWebsiteAdmins < ActiveRecord::Migration
  def self.up
    create_table :website_admins do |t|
      t.integer :website_id
      t.integer :admin_id

      t.timestamps
    end
    
    add_index :website_admins, :website_id
    add_index :website_admins, [:website_id, :admin_id], :unique => true
  end

  def self.down
    drop_table :website_admins
  end
end
