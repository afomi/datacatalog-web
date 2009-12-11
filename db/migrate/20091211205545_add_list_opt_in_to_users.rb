class AddListOptInToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :list_opt_in, :boolean, :default => false
  end

  def self.down
    remove_column :users, :list_opt_in
  end
end
