class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :access_token
      t.string :access_secret

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
