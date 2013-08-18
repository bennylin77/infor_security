class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :subject
      t.text :content
      t.integer :adm_user_id

      t.timestamps
    end
  end
end
