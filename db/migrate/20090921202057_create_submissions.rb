class CreateSubmissions < ActiveRecord::Migration
  def self.up
    create_table :submissions, :force => true do |t|
      t.string :type

      t.string  :name, :email # used if user is not logged in
      t.integer :user_id # used if user is logged in

      t.string :title, :url # used only for DataSubmissions
      t.text :comments
      t.timestamps
    end
    add_index :submissions, :type
    add_index :submissions, :user_id
  end

  def self.down
    remove_index :submissions, :user_id
    remove_index :submissions, :type
    drop_table :submissions
  end
end
