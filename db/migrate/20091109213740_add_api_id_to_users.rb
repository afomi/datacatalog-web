class AddApiIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :api_id, :string
  end

  def self.down
    remove_column :users, :api_id
  end
end
