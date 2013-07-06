class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :adm_user_id
	  t.string :subject
      t.text :content
      t.timestamps
    end
  end
end
