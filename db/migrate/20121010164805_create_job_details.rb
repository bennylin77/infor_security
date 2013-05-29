class CreateJobDetails < ActiveRecord::Migration
  def change
    create_table :job_details, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :job_id
      t.string  :src_ip
      t.integer :log_count
      t.string  :serverity
      t.string  :region
      t.text    :action
      t.integer :threat_id
      t.date :log_date
      t.timestamps
    end
  end
end
