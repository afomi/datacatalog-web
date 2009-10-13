class AddStatusToSubmissions < ActiveRecord::Migration
  def self.up
    add_column :submissions, :status, :string
  end

  def self.down
    remove_column :submissions, :status
  end
end
