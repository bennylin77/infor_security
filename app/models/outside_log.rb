class OutsideLog < ActiveRecord::Base
  attr_accessible :outside_counts_id, :log_time,:src_ip ,:victim_ip, :thread_id, :action, :country, :threat_type, :serverity
  belongs_to :outside_count, :foreign_key=> :outside_counts_id
   
end
