class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :remember_token
      t.string :image
      t.string :oauth_token
      t.string :uid
      t.string :provider
      t.date :oauth_expires_at
      t.text :bio

      t.timestamps
    end

    add_index :users, :remember_token, :unique => true
    add_index :users, :email, :unique => true

  end
end
