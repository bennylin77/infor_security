class OutsideLog < ActiveRecord::Base
  attr_accessible :outside_counts_id, :log_time,:src_ip ,:victim_ip, :threat_id, :action, :country, :threat_type, :serverity
  belongs_to :outside_count
   
end
