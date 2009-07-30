class BeetAuthlogicCreateUser < ActiveRecord::Migration
  def self.up
    unless table_exists?(:users)
      create_table :users do |t|
        t.string    :email
        t.string    :crypted_password
        t.string    :password_salt
        t.string    :persistence_token
        t.string    :single_access_token
        t.string    :perishable_token

        t.integer   :login_count,           :default => 0
        t.integer   :failed_login_count,    :default => 0
        t.datetime  :last_request_at
        t.datetime  :current_login_at
        t.datetime  :last_login_at
        t.string    :current_login_ip
        t.string    :last_login_ip
      end
    end
  end

  def self.down
    drop_table :users
  end
end