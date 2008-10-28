class AddUserToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :user_id, :integer
  end

  def self.down
    remove_column :sites, :user_id
  end
end
