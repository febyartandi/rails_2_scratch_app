class CreateUserSystem < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :activation_code,           :string, :limit => 40
      t.column :activated_at,              :datetime
      t.column :reset_code,                :string

    end
    add_index :users, :login, :unique => true
    add_index :users, :email, :unique => true
    
    create_table "profiles", :force => true do |t|
      t.column :first_name,                :string, :limit => 100
      t.column :last_name,                 :string, :limit => 100
      t.column :address,                   :text
      t.column :city,                      :string, :limit => 100
      t.column :state_prov,                :string, :limit => 100
      t.column :birthdate,                 :date
      t.integer:country_id, :user_id
      
      t.timestamps
    end
    add_index :profiles, :user_id
    add_index :profiles, :country_id
    
    create_table "countries", :force => true do |t|
      t.string :name, :iso_code
      t.timestamps
    end    
    
  end

  def self.down
    drop_table "users"
    drop_table "profiles"
    drop_table "countries"
  end
end
