class CreateJobThreats < ActiveRecord::Migration
  def change
    create_table :job_threats, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :job_id
      t.integer :threat_id
      t.timestamps
    end
  end
end
