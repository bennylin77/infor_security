class CreateAdmUsers < ActiveRecord::Migration
  def change
    create_table :adm_users, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :username
      t.string :hashed_pw
      t.string :salt
      t.string :verify_code
      t.boolean :verified
      t.integer :extend
      t.string :phone
      t.string :email
      t.string :department
      t.integer :campus_buildings_list_id
      t.string :authorization

      t.timestamps
    end
  end
end
