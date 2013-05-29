class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer  :adm_user_id
      t.integer  :assigning_adm_user_id    
      t.integer  :handling_adm_user_id
      t.string :stage1
      t.string :stage2
      t.string :stage3
      t.string :stage4
      t.string :stage5
      t.boolean :deleted
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
