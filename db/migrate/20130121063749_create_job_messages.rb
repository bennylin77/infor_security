class CreateJobMessages < ActiveRecord::Migration
  def change
    create_table :job_messages, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8'  do |t|  
      t.integer :adm_user_id 
      t.integer :job_id
      t.integer :stage_from
      t.string  :type
      t.text    :content
      t.timestamps
    end
  end
end
