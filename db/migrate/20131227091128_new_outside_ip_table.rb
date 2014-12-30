class NewOutsideIpTable < ActiveRecord::Migration
  def change
    
    create_table :outside_counts, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
       t.integer :sum
       t.timestamps
    end
    
    create_table :outside_logs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
       t.belongs_to :outside_counts   # outside_count_id
       t.datetime :log_time
       t.string :src_ip
       t.string :victim_ip
       t.string :threat_id
       t.string :action
       t.string :country
       t.string :serverity
       t.string :threat_type
       t.timestamps
    end
    
  end
end
